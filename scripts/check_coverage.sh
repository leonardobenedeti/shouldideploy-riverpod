BLUE="\e[36;1m%s\e[0m\n"
GREEN="\e[32;1m%s\e[0m\n"
RED="\e[31;1m%s\e[0m\n"

printf "${BLUE}" "Running test"
if ! flutter test --coverage; then
    printf "${RED}" "Failed test"
    exit 1
fi
coverage="$(flutter pub global run test_cov_console -t)"
minCoverage=100
printf "${BLUE}" "Current coverage: ${coverage}"
if [ "$(echo "$coverage < $minCoverage" | bc -l)" -eq 1 ]; then
    printf "${RED}" "Coverage is lower then ${minCoverage}% (minimum)"
    exit 1
fi