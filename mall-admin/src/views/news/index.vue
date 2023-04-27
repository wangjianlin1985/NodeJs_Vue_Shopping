<template>
  <div class="company-container">
    <el-row class="tar">
      <el-button class="mb-20" type="primary" @click="add">新增新闻</el-button>
    </el-row>
    <el-table v-loading="loading" :data="tableData" style="width: 100%">
      <el-table-column prop="id" label="ID" width="100">
      </el-table-column>
      <el-table-column prop="img_url" label="图片" width="80">
        <template slot-scope="scope">
          <el-image :src="baseUrl + scope.row.img_url" style="width:40px;height:40px">
            <div slot="error" class="image-slot">
              <i class="el-icon-video-camera" style="font-size:40px"></i>
            </div>
          </el-image>
        </template>
      </el-table-column>
      <el-table-column prop="title" label="新闻标题" width="400">
      </el-table-column>
      <el-table-column label="发布者" width="220">
        <template slot-scope="scope">
          <el-popover placement="top-start" width="1000" trigger="hover" :content="scope.row.publisher">
            <span class="publisher" slot="reference">{{scope.row.publisher}}</span>
          </el-popover>
        </template>
      </el-table-column>
      <el-table-column prop="newslist.title" label="新闻分类">
      </el-table-column>
      <el-table-column label="操作" width="240">
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
        <el-form-item label="图/视频" prop="img_url">
          <el-upload class="avatar-uploader" action="/api/upload" :show-file-list="false" :on-success="handleAvatarSuccess" :headers="{Authorization:'Bearer '+$store.getters.token}" accept="image/*">
            <img v-if="form.img_url" :src="baseUrl + form.img_url" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="新闻标题" prop="title">
          <el-input placeholder="请输入新闻标题" v-model="form.title"></el-input>
        </el-form-item>
        <el-form-item label="发布者" prop="publisher">
          <el-input placeholder="请输入发布者" v-model="form.publisher"></el-input>
        </el-form-item>
        <el-form-item label="新闻分类" prop="newslist">
          <el-select v-model="form.newslist" clearable placeholder="请选择" @clear="clear('newslist')" style="width:100%">
            <el-option v-for="item in newslist" :key="item.id" :label="item.title" :value="item.id">
            </el-option>
          </el-select>
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
        img_url: "",
        title: "",
        publisher: "",
        newslist: null,
      },
      rules: {
        img_url: [
          { required: true, message: "请上传商品图片或视频", trigger: "change" },
        ],
        title: [{ required: true, message: "请输入新闻标题", trigger: "change" }],
        publisher: [{ required: true, message: "请输入发布者", trigger: "change" }],
        newslist: [{ required: true, message: "请选择新闻分类", trigger: "change" }],
      },
      newslist: [],

      isUploadImage: true, //上传的是否为图片，不是为false
    };
  },
  methods: {
    getnewslist() {
      this.$store.dispatch("newslist/all").then((res) => {
        this.newslist = res;
      });
    },
    getList() {
      this.loading = true;
      this.$store
        .dispatch("news/list", { page: this.page, limit: this.limit })
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
            .dispatch(action ? "news/create" : "news/update", data)
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
        .dispatch("news/remove", { id })
        .then((res) => {
          this.$message.success("删除成功！");
          this.page = 1;
          this.getList();
        })
        .finally(() => {
          this.loading = false;
        });
    },
    operation(id, status) {
      this.loading = true;
      this.$store
        .dispatch("product/operation", { id, status: !status })
        .then((res) => {
          this.$message.success("操作成功！");
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
      this.form.img_url = res.path;
      this.$message.success("上传成功！");
    },
    clear(field) {
      this.form[field] = null;
    }
  },
  created() {
    this.getList();
    this.getnewslist();
  },
};
</script>

<style lang="scss" scoped>
.publisher {
  display: block;
  width: 200px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
