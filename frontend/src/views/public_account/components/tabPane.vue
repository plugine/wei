<template>
  <el-table :data="list" border fit highlight-current-row style="width: 100%">

    <el-table-column align="center" label="ID" width="65"  v-loading="loading"
                     element-loading-text="加载中">
      <template slot-scope="scope">
        <span>{{scope.row.id}}</span>
      </template>
    </el-table-column>

    <el-table-column width="130px" align="center" label="名称">
      <template slot-scope="scope">
        <span>{{scope.row.name}}</span>
      </template>
    </el-table-column>

    <el-table-column width="150px" align="center" label="账号">
      <template slot-scope="scope">
        <span>{{scope.row.account}}</span>
      </template>
    </el-table-column>

    <el-table-column width="110px" align="center" label="appID">
      <template slot-scope="scope">
        <span>{{scope.row.appid}}</span>
      </template>
    </el-table-column>


    <el-table-column width="110px" align="center" label="Secret">
      <template slot-scope="scope">
        <span>{{scope.row.appsecret}}</span>
      </template>
    </el-table-column>

    <el-table-column min-width="180px" label="创建时间">
      <template slot-scope="scope">
        <span>{{scope.row.created_at}}</span>
      </template>
    </el-table-column>

    <el-table-column class-name="status-col" label="操作" width="110">
      <template slot-scope="scope">
        <router-link :to="'/public_account/edit/'+scope.row.id">编辑</router-link>
        <a @click='del(scope.row.id)'>删除</a>
      </template>
    </el-table-column>

  </el-table>
</template>

<script>
import { fetchAccountList, deleteAccount } from '@/api/account'

export default {
  props: {
    type: {
      type: String,
      default: 'all'
    }
  },
  data() {
    return {
      list: null,
      loading: false
    }
  },
  created() {
    this.getList()
  },
  methods: {
    del(id) {
      if (confirm("确定要删除这个公众号？")) {
        deleteAccount(id).then(response => {
          this.getList()
        })
      }
    },
    getList() {
      this.loading = true
      this.$emit('create') // for test
      fetchAccountList().then(response => {
        this.list = response.data.public_accounts
        this.loading = false
      })
    }
  }
}
</script>

