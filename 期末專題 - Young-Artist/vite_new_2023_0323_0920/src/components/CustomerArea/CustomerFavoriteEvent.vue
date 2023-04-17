<template>
    <CustomerMenu />
    <el-row>
        <el-col :span=3></el-col>
        <el-col :span=18>
            <h1>我收藏的活動</h1>
            <el-row>
                <el-card v-for="item in displayedCards" :key="item.eventId" shadow="always"
                    :body-style="{ padding: '1px' }">
                    <div class="imagebox">
                        <img :src="ImageUrl + item.eventImage" class="image" />
                    </div>
                    <div style="padding: 10px" class="CardInfo">
                        <div fonts style="padding: 7px; font-size:medium;">{{ item.eventName }}</div>
                        <el-row>
                            <div style="padding: 7PX;font-size:x-small;">
                                {{ item.eventStartTimestamp }}~{{ item.eventEndTimestamp }}
                            </div>
                        </el-row>
                        <el-row>
                            <div style="padding: 7PX;">
                                <el-button type="danger" plain @click="DeleteCollect(item.eventId)" class="button">
                                    <i class="fa-solid fa-trash"></i>
                                    取消收藏
                                </el-button>
                            </div>
                        </el-row>
                    </div>
                </el-card>
            </el-row>
        </el-col>
        <el-col :span=5></el-col>
    </el-row>
    <el-row id="pagelist">
        <el-col :span=5></el-col>
        <el-col :span=14 display="flex">
            <el-row justify="center" style="margin:20px;">
                <el-pagination v-model="currentPage" :page-size="pageSize" :total="total" background
                    layout="prev, pager, next" @current-change="handlePageChange" />
            </el-row>
        </el-col>
        <el-col :span=3></el-col>
    </el-row>
</template>

<script setup lang="ts">
import { onMounted, ref, computed } from 'vue'
import axios from 'axios';
import { useRouter } from 'vue-router'
import { CustomerStore } from '@/stores/CustomerStore'
import { EventStore } from '@/stores/EventStore'
import CustomerMenu from './CustomerMenu.vue';

const router = useRouter()
const CardData = EventStore().cardData
const customerData = CustomerStore().customerData
let EventIdArray = []
let currentPage = ref(1)
let pageSize = ref(6)
let total = ref(0)
const ImageUrl = "https://localhost:7165/Images/"

const getCollectCards = async () => {
    try {
        CardData.splice(0, CardData.length)
        const response = await axios.get(`https://localhost:44393/api/EventCollects/customerid/${customerData[0].customerId}`);
        EventIdArray.splice(0, EventIdArray.length);
        EventIdArray = response.data.map(obj => obj.eventId);
        const array = [];
        console.log(EventIdArray);
        for (let i = 0; i < EventIdArray.length; i++) {
            let responseCard = await axios.get(`https://localhost:44393/api/Events/Id/${EventIdArray[i]}`);
            array.push(responseCard.data[0])
        }
        CardData.splice(0, array.length, ...array)
        console.log(CardData);

        total.value = CardData.length;

    } catch (error) {
        console.log(error);
    }
};
const DeleteCollect = async (EventId: number) => {
    if (confirm("是否確定取消收藏此活動？")) {
        try {
            const response = await axios.delete(`https://localhost:44393/api/EventCollects/Delete?customerid=${customerData[0].customerId}&eventid=${EventId}`)

        } catch (error) {
            console.log(error);
        }
        alert('取消收藏成功');
        getCollectCards();
    }
}

const displayedCards = computed(() => {
    const start = (currentPage.value - 1) * pageSize.value;
    const end = start + pageSize.value;
    total.value = CardData.length;
    return CardData.slice(start, end);
});



const handlePageChange = (page: number) => {
    currentPage.value = page;
};

onMounted(getCollectCards);

</script>  


<style scoped>
.example-pagination-block+.example-pagination-block {
    margin-top: 10px;
}

.example-pagination-block .example-demonstration {
    margin-bottom: 10px;
}

.button {
    position: absolute;
    bottom: 1;
    right: 1;
}

.image {
    width: auto;
    height: 100%;
}

.imagebox {
    height: 130px;
}

.CardInfo {
    height: 100%;
    position: relative;
}

.el-card {
    margin: 10px;
    height: 300pX;
    width: 190px;
}</style>