<template>
  <div class="company-container">
    <el-row class="tar">
      <el-button class="mb-20" type="primary" @click="add">新增公司</el-button>
    </el-row>
    <el-table v-loading="loading" :data="tableData" style="width: 100%">
      <el-table-column prop="id" label="ID" width="100">
      </el-table-column>
      <el-table-column prop="image_url" label="图片" width="180">
        <template slot-scope="scope">
          <el-image :src="baseUrl + scope.row.image_url" style="width:40px;height:40px">
            <div slot="error" class="image-slot">
              <i class="el-icon-picture-outline"></i>
            </div>
          </el-image>
        </template>
      </el-table-column>
      <el-table-column prop="title" label="名称" width="400">
      </el-table-column>
      <el-table-column prop="brief" label="简介">
      </el-table-column>
      <el-table-column label="操作" width="200">
        <template slot-scope="scope">
          <el-button style="margin-right:10px" size="mini" @click="edit(scope.row)">编辑</el-button>
          <el-popconfirm @onConfirm="remove(scope.row.id)" confirm-button-text='好的' cancel-button-text='不用了' icon="el-icon-info" icon-color="red" title="确定删除吗？">
            <el-button slot="reference" size="mini" type="danger">删除</el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination class="tac mt-20" background layout="prev, pager, next" :current-page.sync="page" :page-size="limit" :total="total" @current-change="handleCurrentChange">
    </el-pagination>
    <el-dialog :title="action==='add'?'新增':'编辑'" :visible.sync="visible" width="600px" @close="close">
      <el-form :model="form" :rules="rules" ref="ruleForm" label-width="80px">
        <el-form-item label="主图" prop="image_url">
          <el-upload class="avatar-uploader" action="/api/upload" :show-file-list="false" :on-success="handleAvatarSuccess" :headers="{Authorization:'Bearer '+$store.getters.token}">
            <img v-if="form.image_url" :src="baseUrl + form.image_url" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="名称" prop="title">
          <el-input placeholder="请输入名称" v-model="form.title"></el-input>
        </el-form-item>
        <el-form-item label="简介" prop="brief">
          <el-input placeholder="请输入简介" type="textarea" :rows="5" v-model="form.brief"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="visible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "User",
  data() {
    return {
      baseUrl: process.env.VUE_APP_BASE_API,
      page: 1,
      limit: 10,
      total: 0,
      loading: false,
      tableData: [],
      action: "",
      visible: false,
      currentRowId: null,
      form: {
        image_url: "",
        title: "",
        brief: "",
      },
      rules: {
        image_url: [
          { required: true, message: "请上传主图", trigger: "change" },
        ],
        title: [{ required: true, message: "请输入名称", trigger: "change" }],
        brief: [{ required: true, message: "请输入简介", trigger: "change" }],
      },
    };
  },
  methods: {
    getList() {
      this.loading = true;
      this.$store
        .dispatch("company/list", { page: this.page, limit: this.limit })
        .then((res) => {
          this.tableData = res.rows;
          this.total = res.count;
        })
        .finally(() => (this.loading = false));
    },
    add() {
      this.action = "add";
      this.visible = true;
    },
    edit(row) {
      this.action = "edit";
      this.visible = true;
      const { id } = row;
      this.currentRowId = id;
      this.$nextTick(() => {
        Object.keys(this.form).forEach((key) => {
          this.form[key] = row[key];
        });
      });
    },
    save() {
      this.$refs["ruleForm"].validate((valid) => {
        if (valid) {
          this.loading = true;
          const action = this.action === "add";
          const data = Object.assign(this.form, {
            ...(action ? {} : { id: this.currentRowId }),
          });
          this.$store
            .dispatch(action ? "company/create" : "company/update", data)
            .then(() => {
              this.$message.success(`${action ? "新增成功" : "更新成功"}`);
              this.visible = false;
              this.$refs["ruleForm"].resetFields();
              this.getList();
            })
            .finally((_) => (this.loading = false));
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    remove(id) {
      this.loading = true;
      this.$store
        .dispatch("company/remove", { id })
        .then((res) => {
          this.$message.success("删除成功！");
          this.page = 1;
          this.getList();
        })
        .finally(() => {
          this.loading = false;
        });
    },
    handleCurrentChange(val) {
      this.page = val;
      this.getList();
    },
    close() {
      if (this.action === "edit") {
        this.$refs["ruleForm"].resetFields();
      }
    },
    handleAvatarSuccess(res, file) {
      this.form.image_url = res.path
      this.$message.success("上传成功！")
    },
  },
  created() {
    this.getList();
  },
};
</script>

<style lang="scss" scoped>
</style>
