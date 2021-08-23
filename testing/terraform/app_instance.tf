resource "aws_ecr_repository" "fakeecrtest" {
  name                 = "fakeecrtest1"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}