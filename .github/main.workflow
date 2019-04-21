workflow "New workflow" {
  on = "push"
  resolves = ["Check GraphQL Schema Is Up to Date"]
}

action "Install dependencies" {
  uses = "NyanKiyoshi/actions-diff@master"
  args = "- sudo apt-get update && sudo apt-get install -y libxml2 libssl1.1 libcairo2 libpango-1.0-0 libpangocairo-1.0-0 libgdk-pixbuf2.0-0 shared-mime-info mime-support && pip install -r requirements.txt -r requirements_dev.txt"
}

action "Check GraphQL Schema Is Up to Date" {
  uses = "NyanKiyoshi/actions-diff@master"
  needs = ["Install dependencies"]
  args = "saleor/graphql/schema.graphql SECRET_KEY=abc python manage.py get_graphql_schema"
}
