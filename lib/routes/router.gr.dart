// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    ConnectRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ConnectScreen(),
      );
    },
    AuthRoute.name: (routeData) {
      final args =
          routeData.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: AuthScreen(key: args.key),
      );
    },
    MainRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    OperationRoute.name: (routeData) {
      final args = routeData.argsAs<OperationRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: OperationScreen(
          key: args.key,
          operation: args.operation,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          ConnectRoute.name,
          path: '/',
        ),
        RouteConfig(
          AuthRoute.name,
          path: '/auth-screen',
        ),
        RouteConfig(
          MainRoute.name,
          path: '/main-screen',
        ),
        RouteConfig(
          OperationRoute.name,
          path: '/operation-screen',
        ),
      ];
}

/// generated route for
/// [ConnectScreen]
class ConnectRoute extends PageRouteInfo<void> {
  const ConnectRoute()
      : super(
          ConnectRoute.name,
          path: '/',
        );

  static const String name = 'ConnectRoute';
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<AuthRouteArgs> {
  AuthRoute({Key? key})
      : super(
          AuthRoute.name,
          path: '/auth-screen',
          args: AuthRouteArgs(key: key),
        );

  static const String name = 'AuthRoute';
}

class AuthRouteArgs {
  const AuthRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute()
      : super(
          MainRoute.name,
          path: '/main-screen',
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [OperationScreen]
class OperationRoute extends PageRouteInfo<OperationRouteArgs> {
  OperationRoute({
    Key? key,
    required Operation operation,
  }) : super(
          OperationRoute.name,
          path: '/operation-screen',
          args: OperationRouteArgs(
            key: key,
            operation: operation,
          ),
        );

  static const String name = 'OperationRoute';
}

class OperationRouteArgs {
  const OperationRouteArgs({
    this.key,
    required this.operation,
  });

  final Key? key;

  final Operation operation;

  @override
  String toString() {
    return 'OperationRouteArgs{key: $key, operation: $operation}';
  }
}
