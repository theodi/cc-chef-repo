name "base"
description "sample base role"

run_list(
    "recipe[odi-apt]",
    "recipe[odi-chef-client::config]",
    "recipe[git]",
    "recipe[odi-pk]",
    "recipe[build-essential]",
    "recipe[postfix]",
    "recipe[ntp]",
    "recipe[odi-users]",
    "recipe[odi-xml]",
    "recipe[xslt]",
    "recipe[mysql::client]",
    "recipe[dictionary]",
    "recipe[nodejs::install_from_package]"
)

