<template>
    <el-row style="margin-top:20px; margin-bottom: 30px;">
        <el-col :span=5></el-col>
        <el-col :span=14>
            <div class="demo-input-size">
                <el-input v-model="userInput" class="w-50 m-2" placeholder="搜尋活動" :suffix-icon="Search"
                    style="margin-right: 20px;" @keyup.enter="getKeyWord()" />
            </div>
        </el-col>
        <el-col :span=5></el-col>
    </el-row>
    <el-row>
        <el-col :span=5></el-col>
        <el-col :span=14>
            <el-row style="display: flex; justify-content: space-around;">
                <el-card shadow="always" :body-style="{ padding: '1px' }" v-for="item in displayedCards"
                    :key="item.eventId">
                    <div>
                        <img :src="ImageUrl + item.eventImage" class="image" />
                    </div>
                    <div class="CardInfo">
                        <div fonts style="font-size:x-large;">{{ item.eventName }}</div>
                        <hr>
                        <el-row>
                            <div>
                                <i class="fa-regular fa-calendar-days"></i>開始時間：{{ item.eventStartTimestamp }}
                            </div>
                        </el-row>
                        <el-row>
                            <div>
                                <i class="fa-regular fa-calendar-days"></i>結束時間：{{ item.eventEndTimestamp }}
                            </div>
                        </el-row>
                    </div>
                    <el-button type="primary" plain @click="getEventId(item.eventId)" class="button">活動詳細
                        <i class="fa-solid fa-arrow-right"></i>
                    </el-button>
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
        <el-col :span=5></el-col>
    </el-row>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue'
import { onMounted, ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import { useRoute } from 'vue-router';
import { EventStore } from '@/stores/EventStore';
import axios from 'axios';

let currentPage = ref(1)
let pageSize = ref(6)
let total = ref(0)
let userInput = ref("")
const route = useRoute()
const router = useRouter()
const CardData = EventStore().cardData
const keyword = EventStore().keyword
const ImageUrl = "https://localhost:7165/Images/"
const getEventId = (EventId: number) => {
    router.push({ name: "EventDetailView", params: { eventId: EventId } })
}

const getCards = async () => {
    if (keyword != "") {
        console.log(keyword)
        await axios.get(`https://localhost:44393/api/Events/KeyWord/${userInput.value}`)
            .then(response => {
                console.log(response.data);
                CardData.splice(0, CardData.length, ...response.data)
                console.log(CardData);
            })
            .catch(error => {
                console.log(error);
            })
        window.scrollTo(0, 0)
        EventStore().keyword = ""
    } else {

        const response = await axios.get('https://localhost:44393/api/Events');
        console.log(response.data);
        CardData.splice(0, response.data.length, ...response.data);
        total.value = CardData.length;
        window.scrollTo(0, 0)
        EventStore().keyword = ""

    }

};


const getKeyWord = async () => {
    await axios.get(`https://localhost:44393/api/Events/KeyWord/${userInput.value}
`)
        .then(response => {
            console.log(response.data);
            CardData.splice(0, CardData.length, ...response.data)
        })
        .catch(error => {
            console.log(error);
        })
    EventStore().keyword = ""
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

onMounted(getCards);

</script>  


<style scoped>
.example-pagination-block+.example-pagination-block {
    margin-top: 10px;
}

.example-pagination-block .example-demonstration {
    margin-bottom: 10px;
}

i {
    margin: 5px;
}

.button {
    position: absolute;
    bottom: 0;
    right: 0;
    margin: 15px;
}

.image {
    width: auto;
    height: 200px;
}

.CardInfo {
    padding: 10px;
    height: 100%;
    margin: 5px;
}

.el-card {
    margin: 5px;
    height: 400pX;
    width: 280px;
    position: relative;
}
</style>