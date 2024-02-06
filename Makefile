riverpod-watch:
	@dart run build_runner watch

unit-tests:
	@flutter test

check-coverage-verbose:
	@dart pub global run full_coverage -i main.dart && flutter test --coverage && flutter pub global run test_cov_console

check-coverage:
	@dart pub global run full_coverage -i main.dart && flutter test --coverage && flutter pub global run test_cov_console -t

