<?php echo "GO to /monstra";
$current_url='http://'.$_SERVER['SERVER_NAME'].':'.$_SERVER["SERVER_PORT"]."/monstra";
$dom = new DOMDocument();
$xmlpatch='./monstra/storage/database/options.table.xml';
$res=$dom->load($xmlpatch);
$vaule=$dom->getElementsByTagName('options')->item(6)->getElementsByTagName('value')->item(0)->nodeValue;
$compare_url=$vaule;
if ($current_url!=$compare_url){
    $dom->getElementsByTagName('options')->item(6)->getElementsByTagName('value')->item(0)->nodeValue = $current_url;
    $dom->save($xmlpatch);
    header("refresh: 0");
};
?>