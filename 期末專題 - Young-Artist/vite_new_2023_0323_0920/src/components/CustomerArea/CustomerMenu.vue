<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { Ticket, CollectionTag, ShoppingBag, EditPen, Right, ShoppingCart } from '@element-plus/icons-vue'
// 視窗相關
const checkWindowWidth = () => {
    windowWidth.value = window.innerWidth
}
const windowWidth = ref(0)
window.addEventListener('resize', () => {
    windowWidth.value = window.innerWidth
})

onMounted(() => {
    checkWindowWidth();
})
</script>

<template>
    <el-row v-if="windowWidth <= 768">
        <el-col>
            <ul id="minWindowCustomerArea">
                <li>
                    <RouterLink to="/CustomerTicketView">
                        <div>
                            <el-icon>
                                <Ticket class="icon" />
                            </el-icon>
                        </div>
                        <div>
                            活動票券
                        </div>
                    </RouterLink>
                </li>
                <li>
                    <RouterLink to="/CustomerCommodity">
                        <div>
                            <el-icon>
                                <ShoppingBag class="icon" />
                            </el-icon>
                        </div>
                        <div>
                            周邊商品
                        </div>
                    </RouterLink>
                </li>
                <li>
                    <RouterLink to="/CustomerShoppingcartView">
                        <div>
                            <el-icon>
                                <ShoppingCart class="icon" />
                            </el-icon>
                        </div>
                        <div>
                            購物車
                        </div>
                    </RouterLink>
                </li>
                <li>
                    <RouterLink to="/CustomerFavoriteEventView">
                        <div>
                            <el-icon>
                                <CollectionTag class="icon" />
                            </el-icon>
                        </div>
                        <div>
                            收藏活動

                        </div>
                    </RouterLink>
                </li>
                <li>
                    <RouterLink to="/EditCustomerView">
                        <div>
                            <el-icon>
                                <EditPen class="icon" />
                            </el-icon>
                        </div>
                        <div>
                            修改會員
                        </div>
                    </RouterLink>
                </li>
                <li>
                    <RouterLink to="/">
                        <div>
                            <el-icon>
                                <Right class="icon" />
                            </el-icon>
                        </div>
                        <div>
                            登出
                        </div>
                    </RouterLink>
                </li>
            </ul>
        </el-col>
    </el-row>
</template>

<style scoped lang="less">
#minWindowCustomerArea {
    display: flex;
    list-style: none;
    justify-content: space-around;
    padding: 0;
    flex: 1;

    li {
        border: 1px solid rgb(66, 140, 203);
        width: 100%;
        border-radius: 10%;
        padding: 3px;
        background-color: white;

        div {
            text-align: center;

        }

        a {
            text-decoration: none;
            font-size: 16px;
            color: rgb(0, 0, 0);
        }

        .icon {
            color: rgb(66, 140, 203);
        }
    }

    li:hover {
        background-color: rgb(66, 140, 203);

        a {
            text-decoration: none;
            font-size: 16px;
            color: rgb(255, 255, 255);
        }

        .icon {
            color: rgb(255, 255, 255);
        }
    }
}
</style>