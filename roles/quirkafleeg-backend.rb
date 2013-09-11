name "quirkafleeg-backend"
description "quirkafleeg backend wrapper role"

default_attributes(
    :apps => {
        'signonotron2'  => {
            :deploy_name => 'signon',
            :port        => 4000,
            :mysql_db    => 'signon',
            :migrate     => 'bundle exec rake db:migrate'
        },
        'static'        => {
            :port        => 4010,
            :assets_path => 'static'
        },
        'panopticon'    => {
            :port     => 4020,
            :mongo_db => 'govuk_content_publisher'
        },
        'publisher'     => {
            :port     => 4030,
            :mongo_db => 'govuk_content_publisher'
        },
        'content_api'   => {
            :deploy_name       => 'contentapi',
            :port              => 4040,
            :precompile_assets => false,
            :mongo_db          => 'govuk_content_publisher'
        },
        'asset-manager' => {
            :port              => 4050,
            :mongo_db          => 'govuk_content_publisher',
            :precompile_assets => false
        },
    }
)

run_list(
    "role[quirkafleeg]"
)