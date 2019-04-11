## 首次clone步骤

简短版本:
```shell
git clone --recursive http://git.hzztai.com/mdt/app.git -b develop
```

如果已经克隆了主库但没初始化子模块，则用：

```shell
git submodule update --init --recursive
```

## 版本号
修改pubspec.yaml文件中version字段即可修改版本号，`+`前面的为`build-name`也就是大版本号，后面的为`build-number`

## App Icon

1. 更改`icon/icon.png` 尺寸1024*1024
2. 根目录执行： `flutter pub pub run flutter_launcher_icons:main`

## 开发
### 代码提交
> 无论是pull还是push，一定要先操作`common`仓库，再操作主仓库

> 由于要开发HD版本，请将所有的非布局代码(`provider`和`service`,公共组件)都放到`common`文件夹内

### json序列化
由于`Dart`的语言特使，我们强烈需要一个json序列化来帮助我们生成对应的`class`。这个已经配置好了，请参见`lib/common/service/auth/user.dart`文件写法。
```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  static String tokenKey = 'token';
  static String userKey = 'user';

  final String name;
  @JsonKey(name: 'realname')
  final String realName;
  final int id;
  final String email;
  @JsonKey(name: 'organization_id')
  final int organizationId;

  User({this.name = '', this.realName = '', this.id = -1, this.email = '', this.organizationId = -1});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

```

然后在项目根目录执行`flutter packages pub run build_runner build`，就可以生成对应的`user.g.dart`，简单方便。

详细教程请参见 [完整实例](https://github.com/dart-lang/json_serializable/blob/master/example/lib/example.dart)


## 代码规范
规范参考[Dart规范](https://www.dartlang.org/guides/language/effective-dart/style)

### 文件夹结构
1. `images` 图片
2. `services` 服务层，接口，逻辑
3. `views` 页面
4. `widgets` 公共组件，建议每个组件建立一个文件夹
5. `views`内，通过文件夹细化路由

### 命名
文件夹命名和文件命名都采用`_`下划线命名

1. `provider`和`service`文件，用`_provider`和`_service`结尾，如`auth_service.dart`
2. 类名大写驼峰 `AuthService`
3. 变量名小写驼峰 `authStatus`
4. 导出包名 小写下划线 `import 'package:rxdart/rxdart.dart' as rx`
5. `const`常量用小写驼峰
6. 当遇到缩写时，如果缩写长于2位，用小写(大写驼峰情况下首字母大写)，以内用大写 `HttpRequest`,`IOStream`
7. 不要使用命名字母前缀，如 `kDefaultTimeout`,应该`defaultTimeout`
8. 尽量使用`Flutter`和`Dart`默认的格式化
9. 控制单行长度在80以内
10. 逻辑代码用花括号包裹


### 引入顺序
每一类之间用空行隔开
1. dart sdk内的库
2. flutter内的库
3. 第三方库
4. 自己的库
5. 相对路径引用
