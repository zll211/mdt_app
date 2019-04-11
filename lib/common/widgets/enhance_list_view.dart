import 'dart:async';

import 'package:flutter/material.dart';

typedef PaginatedGetList<T> = Future<List<T>> Function({@required int page, @required int pageSize});

typedef ItemBuilder<T> = Widget Function(BuildContext context, T item, int index);
typedef CanLoadMore<T> = bool Function(List<T> list, int pageSize);
typedef HandleList<T> = List<T> Function(List<T> list, {List<T> extraData});
typedef WidgetCallBack = Widget Function();

List<T> _defaultHandleList<T>(List<T> list, {List<T> extraData}) => list;

class EnhancedListView<T> extends StatefulWidget {
  final PaginatedGetList<T> getListFuture;
  final ItemBuilder<T> itemBuilder;
  final Key key;
  final CanLoadMore<T> canLoadMore;
  final Widget emptyView;
  final double offsetHeight;
  final HandleList<T> handleList;
  final Stream<List<T>> extraDataStream;
  final double paddingTop;
  final bool reverse;

  EnhancedListView(
      {@required this.key,
      @required this.getListFuture,
      @required this.itemBuilder,
      this.offsetHeight = 48.0,
      this.emptyView,
      this.canLoadMore,
      this.extraDataStream,
      HandleList<T> handleListFun,
      this.paddingTop: 0.0,
      this.reverse: false})
      : assert(itemBuilder != null),
        this.handleList = handleListFun ?? _defaultHandleList,
        super(key: key);

  @override
  _EnhancedListViewState createState() => _EnhancedListViewState<T>();
}

class _EnhancedListViewState<T> extends State<EnhancedListView<T>> {
  get _hasExtraDataStream => widget.extraDataStream != null;

  ScrollController _scrollController = ScrollController();

  StreamSubscription _extraSubscript;

  bool _isActive = true;

  @override
  void initState() {
    print("#####_EnhancedListViewState init state");
    super.initState();
    _getList(isInit: true);
    if (_hasExtraDataStream) {
      _extraSubscript = widget.extraDataStream.listen((data) {
        if (_isActive) {
          List<T> returnStreamList = data;
          setState(() {
            _extraList = returnStreamList;
          });
        }
      });
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && _canLoadMore) {
        _getList();
      }
    });
  }

  @override
  void dispose() {
    _extraSubscript?.cancel();
    _scrollController.dispose();
    _isActive = false;
    super.dispose();
  }

  List<T> _list = [];
  List<T> _extraList = [];
  bool _isLoading = false, _canLoadMore = true, _isPullToRefresh = false;
  int _page = 0;
  final _pageSize = 15;

  Future<void> _getList({bool isInit = false, bool isPull = false}) async {
    if (isInit || isPull) {
      _page = 1;
    } else {
      _page += 1;
    }
    setState(() {
      if (isPull) {
        _isPullToRefresh = true;
      } else {
        _isLoading = true;
      }
    });
    final _returnFutureList = await widget.getListFuture(page: _page, pageSize: _pageSize);
    bool _result = widget.canLoadMore == null
        ? _returnFutureList.length >= _pageSize
        : widget.canLoadMore(_returnFutureList, _pageSize);

    if (_isActive) {
      setState(() {
        _canLoadMore = _result;
        _isLoading = false;
        _isPullToRefresh = false;
        _list = isInit || isPull ? _returnFutureList : _list + _returnFutureList;
      });
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  Widget _content(BuildContext context) {
    List<T> _finalList = _list;
    if (_list.isEmpty) {
      if (!_isLoading && !_isPullToRefresh) {
        _finalList = _hasExtraDataStream ? widget.handleList(_list, extraData: _extraList) : _list;
      }
    } else {
      _finalList = _hasExtraDataStream ? widget.handleList(_list, extraData: _extraList) : _list;
    }
    return ListView.builder(
      reverse: widget.reverse,
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: _finalList.length + 1,
      itemBuilder: (context, index) {
        if (index == _finalList.length) {
          if (_finalList.isEmpty) {
            if (!_isLoading && !_isPullToRefresh) {
              return widget.emptyView == null
                  ? Container(
                      height: 300.0,
                      child: Center(child: Text('没有更多了')),
                    )
                  : widget.emptyView;
            } else if (_isLoading) {
              return Container(
                height: 300.0,
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return Container(
                height: 300.0,
              );
            }
          } else {
            // list has items
            if (_isLoading) {
              return Container(
                height: widget.offsetHeight,
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return Container(height: widget.offsetHeight);
            }
          }
        }
        return widget.itemBuilder(context, _finalList[index], index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reverse) {
      return _content(context);
    } else {
      return RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            if (_isLoading) {
              return;
            }
            await _getList(isPull: true);
            return;
          },
          child: _content(context));
    }
  }
}
