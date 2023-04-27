<template>
  <div class="navbar">
    <hamburger :is-active="sidebar.opened" class="hamburger-container" @toggleClick="toggleSideBar" />

    <breadcrumb class="breadcrumb-container" />

    <div class="right-menu">
      <el-dropdown class="avatar-container" trigger="click">
        <div class="avatar-wrapper">
          <span class="name">{{name}}</span>
          <i class="el-icon-caret-bottom" />
        </div>
        <el-dropdown-menu slot="dropdown" class="user-dropdown">
          <el-dropdown-item>
            <span style="display:block;" @click="visible=true">修改密码</span>
          </el-dropdown-item>
          <el-dropdown-item divided @click.native="logout">
            <span style="display:block;">退出登录</span>
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
    <el-dialog title="修改密码" :visible.sync="visible" width="500px" center @close="close">
      <el-form :model="form" :rules="rules" ref="form" label-width="100px" class="demo-ruleForm">
        <el-form-item label="旧密码：" prop="op">
          <el-input type="password" v-model="form.op" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item label="新密码：" prop="np">
          <el-input type="password" v-model="form.np" auto-complete="off"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="visible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import Breadcrumb from "@/components/Breadcrumb";
import Hamburger from "@/components/Hamburger";
import md5 from "md5";

export default {
  components: {
    Breadcrumb,
    Hamburger,
  },
  data() {
    return {
      visible: false,
      form: {
        op: "",
        np: "",
      },
      rules: {
        op: [
          { required: true, message: "请输入旧密码", trigger: "blur" },
          {
            pattern: /^[a-zA-Z0-9_]{6,12}$/,
            message: "密码为6-12位，数字、字母、下划线",
            trigger: "blur",
          },
        ],
        np: [
          { required: true, message: "请输入新密码", trigger: "blur" },
          {
            pattern: /^[a-zA-Z0-9_]{6,12}$/,
            message: "密码为6-12位，数字、字母、下划线",
            trigger: "blur",
          },
        ],
      },
    };
  },
  computed: {
    ...mapGetters(["sidebar", "name"]),
  },
  methods: {
    toggleSideBar() {
      this.$store.dispatch("app/toggleSideBar");
    },
    save() {
      this.$refs["form"].validate((valid) => {
        if (valid) {
          const loginParams = { ...this.form };
          loginParams.op = md5(this.form.op.trim());
          loginParams.np = md5(this.form.np.trim());
          this.$store.dispatch("user/changepwd", loginParams).then(() => {
            this.$message.success("修改成功");
            this.$refs["form"].resetFields();
            this.visible = false;
          });
        }
      });
    },
    close() {
      this.$refs["form"].resetFields();
    },
    async logout() {
      await this.$store.dispatch("user/logout");
      this.$router.push(`/login?redirect=${this.$route.fullPath}`);
    },
  },
};
</script>

<style lang="scss" scoped>
.navbar {
  height: 50px;
  overflow: hidden;
  position: relative;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);

  .hamburger-container {
    line-height: 46px;
    height: 100%;
    float: left;
    cursor: pointer;
    transition: background 0.3s;
    -webkit-tap-highlight-color: transparent;

    &:hover {
      background: rgba(0, 0, 0, 0.025);
    }
  }

  .breadcrumb-container {
    float: left;
  }

  .right-menu {
    float: right;
    height: 100%;
    line-height: 50px;

    &:focus {
      outline: none;
    }

    .right-menu-item {
      display: inline-block;
      padding: 0 8px;
      height: 100%;
      font-size: 18px;
      color: #5a5e66;
      vertical-align: text-bottom;

      &.hover-effect {
        cursor: pointer;
        transition: background 0.3s;

        &:hover {
          background: rgba(0, 0, 0, 0.025);
        }
      }
    }
    .avatar-container {
      cursor: pointer;
      margin-right: 30px;
      .name {
        font-size: 16px;
        font-weight: bold;
        margin-right: 10px;
      }
    }
  }
}
</style>
