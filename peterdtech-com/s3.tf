resource "aws_s3_bucket" "peterdemirdjian_com_ue1" {
  bucket = "peterdemirdjian-com-ue1"
}

import {
  id = "peterdemirdjian-com-ue1"
  to = aws_s3_bucket.peterdemirdjian_com_ue1
}
