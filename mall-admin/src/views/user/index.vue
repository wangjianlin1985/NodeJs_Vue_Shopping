<template>
  <div class="user-container">
    <el-table v-loading="loading" :data="tableData" style="width: 100%">
      <el-table-column prop="id" label="ID" width="100">
      </el-table-column>
      <el-table-column prop="username" label="用户名">
      </el-table-column>
      <el-table-column prop="name" label="姓名">
      </el-table-column>
      <el-table-column prop="gender" label="性别">
      </el-table-column>
      <el-table-column label="操作" width="100">
        <template slot-scope="scope">
          <el-popconfirm @onConfirm="remove(scope.row.id)" confirm-button-text='好的' cancel-button-text='不用了' icon="el-icon-info" icon-color="red" title="确定删除吗？">
            <el-button slot="reference" size="mini" type="danger">删除</el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination class="tac mt-20" background layout="prev, pager, next" :current-page.sync="page" :page-size="limit" :total="total" @current-change="handleCurrentChange">
    </el-pagination>
  </div>
</template>

<script>
export default {
  name: "User",
  data() {
    return {
      tableData: [],
      page: 1,
      limit: 10,
      total: 0,
      loading: false,
    };
  },
  methods: {
    handleCurrentChange(val) {
      this.page = val;
      this.getList();
    },
    getList() {
      this.loading = true;
      this.$store
        .dispatch("user/list", { page: this.page, limit: this.limit })
        .then((res) => {
          this.tableData = res.rows;
          this.total = res.count;
        })
        .finally(() => {
          this.loading = false;
        });
    },
    remove(id) {
      this.loading = true;
      this.$store
        .dispatch("user/remove", { id })
        .then((res) => {
          this.$message.success("删除成功！");
          this.page = 1;
          this.getList();
        })
        .finally(() => {
          this.loading = false;
        });
    },
  },
  created() {
    this.getList();
  },
};
</script>

<style lang="scss" scoped>
</style>
