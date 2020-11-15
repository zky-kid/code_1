/**
* 删除左右两端的空格
*/
String.prototype.trim=function(){
     return this.replace(/(^\s*)|(\s*$)/g, '');
}
