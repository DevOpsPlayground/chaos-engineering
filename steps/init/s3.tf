resource "aws_s3_bucket" "playground_assets" {
  bucket = "${local.account_id}-${var.region}-oct-assets"

  force_destroy = true # Destroy all objects in the bucket before destroying the bucket
}

import {
  to = aws_s3_bucket.playground_assets
  id = var.asset_bucket
}