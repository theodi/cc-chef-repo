name "base"
description "sample base role"

run_list(
    "recipe[postfix]",
    "recipe[ntp]"
)