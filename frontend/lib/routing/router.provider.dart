import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'router.dart';

final Provider<AppRouter> routerProvider = Provider((ref) => AppRouter(ref));
