<template>
  <div class="createPost-container">
    <el-form class="form-container" :model="postForm" ref="postForm">

      <sticky :className="'sub-navbar '+postForm.status">
        <template v-if="fetchSuccess">
          <el-button v-loading="loading" style="margin-left: 10px;" type="success" @click="submitForm()">发布
          </el-button>
        </template>
        <template v-else>
          <el-tag>上传失败，请联系管理员</el-tag>
        </template>

      </sticky>

      <div class="createPost-main-container">
        <el-row>
          <el-col :span="21">
            <el-form-item style="margin-bottom: 40px;" prop="title">
              <MDinput name="name" v-model="postForm.name" required :maxlength="100">
                公众号名称
              </MDinput>
            </el-form-item>

            <div class="postInfo-container">
              <el-row>
                <el-col :span="18">
                  <el-tooltip class="item" effect="dark" content="公众号账号" placement="top">
                    <el-form-item label-width="80px" label="账号:" class="postInfo-container-item">
                      <el-input placeholder="" style='min-width:150px;' v-model="postForm.account">
                      </el-input>
                    </el-form-item>
                  </el-tooltip>
                </el-col>
              </el-row>
            </div>
          </el-col>
        </el-row>

        <el-form-item style="margin-bottom: 40px;" label-width="80px" label="APPID:">
          <el-input type="textarea" class="article-textarea" :rows="1" autosize placeholder="请输入APPID" v-model="postForm.appid">
          </el-input>
        </el-form-item>

        <el-form-item style="margin-bottom: 40px;" label-width="80px" label="APPSecret:">
          <el-input type="textarea" class="article-textarea" :rows="1" autosize placeholder="请输入APPSECRET" v-model="postForm.appsecret">
          </el-input>
        </el-form-item>
      </div>
    </el-form>

  </div>
</template>

<script>
import MDinput from '@/components/MDinput'
import Multiselect from 'vue-multiselect'// 使用的一个多选框组件，element-ui的select不能满足所有需求
import 'vue-multiselect/dist/vue-multiselect.min.css'// 多选框组件css
import Sticky from '@/components/Sticky' // 粘性header组件
import { fetchAccount, createAccount, updateAccount } from '@/api/account'

const defaultForm = {
  name: '',
  account: '',
  appid: '',
  appsecret: '',
}

export default {
  name: 'accountEditor',
  components: { MDinput, Multiselect, Sticky },
  props: {
    isEdit: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      id: -1,
      value: '',
      postForm: Object.assign({}, defaultForm),
      fetchSuccess: true,
      loading: false
    }
  },
  computed: {
  },
  created() {
    if (this.isEdit) {
      this.id = this.$route.params.id
      this.fetchData(this.id)
    } else {
      this.postForm = Object.assign({}, defaultForm)
    }
  },
  methods: {
    fetchData(id) {
      fetchAccount(id).then(response => {
        console.log(response.data);
        this.postForm = response.data.account
      }).catch(err => {
        this.fetchSuccess = false
        console.log(err)
      })
    },
    submitForm() {
      console.log(this.templat)
      this.loading = true
      if (this.id == -1) {
        // 新建活动
        createAccount(this.postForm).then(response => {
          console.log(response.data)
          this.$notify({
            title: '成功',
            message: '创建活动公众号',
            type: 'success',
            duration: 2000
          })
          this.loading = false
        })
      } else {
        updateAccount(this.id, this.postForm).then(response => {
          console.log(response.data)
          if (response.data.code != 200) {
            this.$notify({
            title: '失败',
            message: '修改活动失败，请检查参数',
            type: 'error',
            duration: 2000
            })
          }else {
            this.$notify({
              title: '成功',
              message: '修改活动成功',
              type: 'success',
              duration: 2000
            })
          }
          this.loading = false
        })
      }
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
  @import "src/styles/mixin.scss";
  .item {
    text-align: left;
  }
  .title-prompt{
    position: absolute;
    right: 0px;
    font-size: 12px;
    top:10px;
    color:#ff4949;
  }
  .createPost-container {
    position: relative;
    .createPost-main-container {
      padding: 40px 45px 20px 50px;
      .postInfo-container {
        position: relative;
        @include clearfix;
        margin-bottom: 10px;
        .postInfo-container-item {
          float: left;
        }
      }
      .editor-container {
        min-height: 500px;
        margin: 0 0 30px;
        .editor-upload-btn-container {
          text-align: right;
          margin-right: 10px;
          .editor-upload-btn {
            display: inline-block;
          }
        }
      }
    }
    .word-counter {
      width: 40px;
      position: absolute;
      right: -10px;
      top: 0px;
    }
  }
</style>

