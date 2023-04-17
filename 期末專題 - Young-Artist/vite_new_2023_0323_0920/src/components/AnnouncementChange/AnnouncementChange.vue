<script lang="ts" setup>
import { computed, ref, onMounted, reactive } from 'vue'
import axios from 'axios';
import Navbar from '../Navbar/Navbar.vue';
import { useRouter } from 'vue-router';
import Footer from '../Footer/Footer.vue';

const router = useRouter()

//引入資料庫資料
const url = ref('https://localhost:44393/api/Details/')
interface datatype {
  detailsId: string,
  eventtime: string,
  eventId: string,
  state: string,
  reason: string,
  eventName: string

}
onMounted(async () => {
  await axios.get(`${url.value}`)
    .then(response => {
      console.log(response.data)
      tableData.splice(0, response.data.length, ...response.data)
    })
    .catch(error => {
      console.log(error)
    })
});
const tableData = reactive<datatype[]>([])

//搜尋欄位
const search = ref('')
const filterTableData = computed(() => {

  return tableData.filter(
    (data) =>
      !search.value ||
      data.eventName.toLowerCase().includes(search.value.toLowerCase())
  )
}
)
//跳轉詳細資訊
const gotoDetail = (AId: number) => {
  console.log(AId);

  router.push(`/Detail/${AId}`)
}
//分頁面
let currenPasge = ref(1)
let pagesSize = ref(5)
let background = ref(true)
let total = ref(0)

console.log("tableData:" + tableData.values);


</script> 
<template>
  <el-container>
    <el-header>
      <!-- Header content -->
      <Navbar />
    </el-header>
    <el-row style="padding: 100px;">
      <!-- 左側空白 -->
      <el-col :span="5" :offset="0"></el-col>
      <!-- 中間內容 -->
      <el-col :span="14" :offset="0">
        <el-table :data="filterTableData" style="width: 100%">
          <el-table-column label="活動日期" prop="eventtime" />
          <el-table-column label="活動名稱" prop="eventName" />
          <el-table-column label="目前狀態" prop="state" />
          <el-table-column align="right">
            <template #header>
              <el-input v-model="search" size="small" placeholder="Type to search" />
            </template>
            <template #default="scope">
              <el-button size="small" @click="gotoDetail(scope.row.detailsId)">詳細資訊</el-button>
            </template>
          </el-table-column>
        </el-table>
        <!-- 分頁欄 -->
        <el-row :gutter="20" style="padding: 30px;">
          <el-col :span="8">
            <div class="grid-content ep-bg-purple" />
          </el-col>
          <el-col :span="6" :offset="0">
            <el-pagination v-model="currenPasge" :pagesSize="pagesSize" :total="total" :background="background" small
              backgroundlayout="prev, pager, next" class="mt-4" />
          </el-col>
          <el-col :span="6">
            <div class="grid-content ep-bg-purple" />
          </el-col>
          <el-col :span="6">
            <div class="grid-content ep-bg-purple" />
          </el-col>
        </el-row>
      </el-col>
      <!-- 右側空白 -->
      <el-col :span="5" :offset="0"> </el-col>
    </el-row>
    <footer>
      <Footer />
    </footer>
  </el-container>
</template>

<style lang="less" scoped>
.el-header {
  @media screen and (max-width: 768px) {
    padding-bottom: 0px;

  }
}
</style>