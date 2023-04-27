<template>
  <div id="app">
    <router-view />
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
.mt-20{
  margin-top: 20px;
}
.mb-20{
  margin-bottom: 20px;
}
.tac{
  text-align: center;
}
.tar{
  text-align: right;
}


.avatar-uploader .el-upload {
  width: 200px;
  height: 200px;
  display: flex;
  align-items: center;
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 200px;
  height: 200px;
  line-height: 200px;
  text-align: center;
}
.avatar {
  width: 100%;
  height: auto;
  display: block;
}
</style>
