<?php
$file = "MrWhale.swf"; // Replace with the actual path to your SWF file

header('Content-Type: application/x-shockwave-flash');
header('Content-Disposition: attachment; filename="MrWhale.swf"');
header('Content-Length: ' . filesize($file));

readfile($file);
?>
