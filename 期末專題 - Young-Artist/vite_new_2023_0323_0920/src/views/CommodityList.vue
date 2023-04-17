<template>
  <Navbar />
  <el-row style="margin-top: 40px;">
    <el-col :span=5></el-col>
    <el-col :span=14>
      <el-row>
        <div style="width: 100%;">
          <el-dropdown @command="handleCommand">
            <span class="el-dropdown-link" style="margin-left: 800px;">
              排序<el-icon class="el-icon--right"><arrow-down /></el-icon>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="最新上架">最新上架</el-dropdown-item>
                <el-dropdown-item command="熱銷商品">熱銷商品</el-dropdown-item>
                <el-dropdown-item command="推薦商品">推薦商品 </el-dropdown-item>
                <el-dropdown-item command="價格高到低">價格高到低</el-dropdown-item>
                <el-dropdown-item command="價格低到高">價格低到高</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>

        </div>


        <el-card shadow="hover" v-for="product in displayedProducts" :key="product.id" class="card">
          <div class="image">
            <img :src="url + product.commodityImage" alt="Product image"
              style="width: 200px;height: 150px;padding-bottom: 9px;" />
          </div>
          <div class="body">
            <div class="name" style="padding-bottom: 9px;">{{ product.commodityName }}</div>
            <el-row>
              <el-col :span="6">
                <div class="commodityPrice">{{ product.commodityPrice }}.NT</div>
              </el-col>
              <el-col :span="6" :offset="10"><el-button round @click="gotoCommodity(product.id)"
                  type="button">查看商品</el-button>
              </el-col>
            </el-row>

            <span>


            </span>

          </div>
        </el-card>
      </el-row>
    </el-col>
    <el-col :span=5></el-col>
  </el-row>
  <div class="demo-pagination-block page-format">
    <el-pagination v-model="currentPage" :page-size="pageSize" :total="total" :background="background"
      @current-change="handlePageChange"></el-pagination>
  </div>
  <Footer />
</template>


<script lang="ts" setup>
import { ref, reactive, onMounted, computed, toRefs } from 'vue'
import axios from 'axios';
import { useRouter } from 'vue-router'
import Navbar from '@/components/Navbar/Navbar.vue'
import { ElMessage } from 'element-plus'
import { ArrowDown } from '@element-plus/icons-vue'
import Footer from '@/components/Footer/Footer.vue';
const router = useRouter()
//const store = useCounterStore()
let currentPage = ref(1)
let pageSize = ref(12)
let background = ref(true)
let total = ref(0)
let products = reactive([]);
const url = ref("https://localhost:7165/Images/")
//onsole.log(store.active);


//   const handleSizeChange = (val) => {
//     console.log(`${val} items per page`)
//   }
//   const handleCurrentChange = (val) => {
//     console.log(`current page: ${val}`)
//   }


const gotoCommodity = (CommodityId) => {
  //console.log(CommodityId);
  router.push({ name: 'Commodity', params: { CommodityId: CommodityId } })
  //router.push({ name: 'Commodity' });
}
const getProducts = async () => {
  try {
    const response = await axios.get('https://localhost:44393/api/Commodities');
    console.log(response.data);
    products.splice(0, products.length, ...response.data);
    total.value = products.length;
  } catch (error) {
    console.log(error);
  }

};

const displayedProducts = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value;
  const end = start + pageSize.value;
  return products.slice(start, end);
});

const handlePageChange = (page) => {
  currentPage.value = page;
};

const handleCommand = (command: string) => {
  axios.get(`https://localhost:44393/api/Commodities/Sort/${command}`).then(response => {
    console.log(response.data);
    products.splice(0, products.length, ...response.data);
    total.value = products.length;
    displayedProducts.trigger();
  })
  // ElMessage(`click on item ${command}`)
}

onMounted(getProducts);


</script>

<style scoped>
.page-format {
  display: flex;
  justify-content: center;
  margin-bottom: 30px;
}

.el-dropdown-link {
  font-size: 20px;
  float: right;
}

.demo-pagination-block+.demo-pagination-block {

  margin-top: 10px;
}

.demo-pagination-block .demonstration {
  margin-bottom: 16px;
}

.button {
  padding: 7PX;
  min-height: auto;
  font-size: large;
}

.image {
  width: 100%;
  height: 100%;
  display: block;
}

.el-card {
  margin: 10px;
}

.card {
  width: 250px;
  height: 250px;
  padding: 10px;
}

.commodityPrice {
  font-size: 20px;
  vertical-align: bottom
}
</style>