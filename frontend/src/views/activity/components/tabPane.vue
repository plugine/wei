<template>
  <el-table :data="list" border fit highlight-current-row style="width: 100%">

    <el-table-column align="center" label="ID" width="65"  v-loading="loading"
                     element-loading-text="请给我点时间！">
      <template slot-scope="scope">
        <span>{{scope.row.id}}</span>
      </template>
    </el-table-column>

    <el-table-column width="300px" align="center" label="活动名称">
      <template slot-scope="scope">
        <span>{{scope.row.name}}</span>
      </template>
    </el-table-column>

    <el-table-column min-width="180px" label="是否启用">
      <template slot-scope="scope">
        <span>{{scope.row.enabled}}</span>
      </template>
    </el-table-column>

    <el-table-column width="110px" align="center" label="活动描述">
      <template slot-scope="scope">
        <span>{{scope.row.desc}}</span>
      </template>
    </el-table-column>

    <el-table-column width="120px" label="专属序列号">
      <template slot-scope="scope">
        <span>{{scope.row.idx}}</span>
      </template>
    </el-table-column>

    <el-table-column class-name="status-col" label="操作" width="110">
      <template slot-scope="scope">
        <router-link :to="'/activities/'+scope.row.id+'/edit'">编辑</router-link>
      </template>
    </el-table-column>

  </el-table>
</template>

<script>
import { fetchActivityList } from '@/api/activity'

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
    getList() {
      this.loading = true
      this.$emit('create') // for test
      fetchActivityList({}).then(response => {
        console.log(response)
        this.list = response.data.activities
        this.loading = false
      })
    }
  }
}
</script>

