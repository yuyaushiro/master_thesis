#!/usr/bin/perl

$pdf_update_method = 4;
$pdf_update_command = "find . -type f -name '*.tex' -print0 | xargs -0 sed -i '' -e 's/、/，/g' -e 's/。/．/g'";
