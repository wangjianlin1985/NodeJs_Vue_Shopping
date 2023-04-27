<template>
  <div class="company-container">
    <el-row class="tar">
      <el-button class="mb-20" type="primary" @click="add">新增产品</el-button>
    </el-row>
    <el-table v-loading="loading" :data="tableData" style="width: 100%">
      <el-table-column prop="id" label="ID" width="100">
      </el-table-column>
      <el-table-column prop="image_url" label="图片/视频" width="80">
        <template slot-scope="scope">
          <!-- baseUrl + scope.row.image_url -->
          <el-image :src="/\.(jpg|png|bmp|jpeg|webp)$/.test(scope.row.image_url) ? (baseUrl + scope.row.image_url) : ''" style="width:40px;height:40px">
            <div slot="error" class="image-slot">
              <i class="el-icon-video-camera" style="font-size:40px"></i>
            </div>
          </el-image>
        </template>
      </el-table-column>
      <el-table-column prop="title" label="名称" width="400">
      </el-table-column>
      <el-table-column label="价格" width="100">
        <template slot-scope="scope">
          <span>￥{{scope.row.price}}</span>
        </template>
      </el-table-column>
      <el-table-column label="简介" width="220">
        <template slot-scope="scope">
          <el-popover placement="top-start" width="1000" trigger="hover" :content="scope.row.brief">
            <span class="brief" slot="reference">{{scope.row.brief}}</span>
          </el-popover>
        </template>
      </el-table-column>
      <el-table-column prop="perfume.title" label="香水分类">
      </el-table-column>
      <el-table-column prop="spicer.title" label="香料分类">
      </el-table-column>
      <el-table-column prop="company.title" label="所属公司">
      </el-table-column>
      <el-table-column label="首页最热" width="120" align="center">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.hot" @change="val => hot(val,scope.row.id)"> </el-switch>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="240">
        <template slot-scope="scope">
          <el-button :type="scope.row.status?'success':'info'" size="mini" @click="operation(scope.row.id,scope.row.status)">{{scope.row.status?'下架':'上架'}}</el-button>
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
        <el-form-item label="图/视频" prop="image_url">
          <el-upload class="avatar-uploader" action="/api/upload" :show-file-list="false" :on-success="handleAvatarSuccess" :headers="{Authorization:'Bearer '+$store.getters.token}" accept="image/png, image/bmp, imgae/jpeg, image/webp, video/mp4, video/3gp, video/webm">
            <img v-if="form.image_url && /\.(jpg|png|bmp|jpeg|webp)$/.test(form.image_url)" :src="baseUrl + form.image_url" class="avatar">
            <video v-if="form.image_url && /\.(mp4|3gp|webm)$/.test(form.image_url)" :src="baseUrl + form.image_url" class="avatar" autoplay loop muted/>
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="名称" prop="title">
          <el-input placeholder="请输入名称" v-model="form.title"></el-input>
        </el-form-item>
        <el-form-item label="价格" prop="price">
          <el-input-number v-model="form.price" :precision="2" :min="0" label="价格"></el-input-number>
        </el-form-item>
        <el-form-item label="简介" prop="brief">
          <el-input placeholder="请输入简介" type="textarea" :rows="5" v-model="form.brief"></el-input>
        </el-form-item>
        <el-form-item label="香水分类" prop="perfumeId">
          <el-select v-model="form.perfumeId" clearable placeholder="请选择" @clear="clear('perfumeId')" style="width:100%">
            <el-option v-for="item in perfumes" :key="item.id" :label="item.title" :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="香料分类" prop="spicerId">
          <el-select v-model="form.spicerId" clearable placeholder="请选择" @clear="clear('spicerId')" style="width:100%">
            <el-option v-for="item in spicers" :key="item.id" :label="item.title" :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="所属公司" prop="companyId">
          <el-select v-model="form.companyId" clearable placeholder="请选择" @clear="clear('companyId')" style="width:100%">
            <el-option v-for="item in companys" :key="item.id" :label="item.title" :value="item.id">
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
        image_url: "",
        title: "",
        price: 0,
        brief: "",
        perfumeId: null,
        spicerId: null,
        companyId: null,
      },
      rules: {
        image_url: [
          { required: true, message: "请上传商品图片或视频", trigger: "change" },
        ],
        title: [{ required: true, message: "请输入名称", trigger: "change" }],
        price: [{ required: true, message: "请输入价格", trigger: "change" }],
        brief: [{ required: true, message: "请输入简介", trigger: "change" }],
      },
      perfumes: [],
      spicers: [],
      companys: [],

      isUploadImage: true, //上传的是否为图片，不是为false
    };
  },
  methods: {
    getPerfume() {
      this.$store.dispatch("perfume/all").then((res) => {
        this.perfumes = res;
      });
    },
    getSpicer() {
      this.$store.dispatch("spicer/all").then((res) => {
        this.spicers = res;
      });
    },
    getCompany() {
      this.$store.dispatch("company/all").then((res) => {
        this.companys = res;
      });
    },
    getList() {
      this.loading = true;
      this.$store
        .dispatch("product/list", { page: this.page, limit: this.limit })
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
            .dispatch(action ? "product/create" : "product/update", data)
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
        .dispatch("product/remove", { id })
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
      this.form.image_url = res.path;
      this.$message.success("上传成功！");
    },
    clear(field) {
      this.form[field] = null;
    },
    hot(val, id) {
      this.loading = true;
      this.$store
        .dispatch("product/hot", { id, hot: val })
        .then((res) => {
          this.$message.success("操作成功！");
          this.getList();
        })
        .finally(() => {
          this.loading = false;
        });
    }
  },
  created() {
    this.getList();
    this.getPerfume();
    this.getSpicer();
    this.getCompany();
  },
};
</script>

<style lang="scss" scoped>
.brief {
  display: block;
  width: 200px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
