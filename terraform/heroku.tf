# Create Heroku apps for staging and production
resource "heroku_app" "ci" {
  name   = "${var.app_prefix}-app-ci"
  region = "eu"
}

resource "heroku_app" "staging" {
  name   = "${var.app_prefix}-app-staging"
  region = "eu"
}


resource "heroku_app" "production" {
  name   = "${var.app_prefix}-app-production"
  region = "eu"
}

resource "heroku_pipeline" "test-app" {
  name = "${var.pipeline_name}"
}

# Couple apps to different pipeline stages
resource "heroku_pipeline_coupling" "ci" {
  app      = "${heroku_app.ci.name}"
  pipeline = "${heroku_pipeline.test-app.id}"
  stage    = "development"
}

resource "heroku_pipeline_coupling" "staging" {
  app      = "${heroku_app.staging.name}"
  pipeline = "${heroku_pipeline.test-app.id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "production" {
  app      = "${heroku_app.production.name}"
  pipeline = "${heroku_pipeline.test-app.id}"
  stage    = "production"
}
