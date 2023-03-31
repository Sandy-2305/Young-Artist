<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import axios from 'axios';
import { useRouter } from 'vue-router';
import { useRoute } from 'vue-router';
import Navbar from '../Navbar/Navbar.vue';
import Footer from '../Footer/Footer.vue';
//引入資料庫資料
const router = useRouter()
const route = useRoute()
const AnnouncementID = route.params.detailsId
let eventdetails = reactive([]);

const url = ref(`https://localhost:44393/api/Details/${AnnouncementID}`)
const imgurl = ref(`https://localhost:7165/Images/`)




interface datatype {
    detailsId: number,
    announcementType: string,
    content: string,
    contentTime: string,
    eventId: number,
    eventName: string,
    reason: string,
    eventImage: string

}
onMounted(() => {
    if (AnnouncementID) {
        axios
            .get(`${url.value}`)
            .then(response => {
                datatype.splice(0, response.data.length, ...response.data);
            })
            .catch(error => {
                console.log(error);
            });
    }
});


const datatype = reactive<datatype[]>([])
const goback = () => {
    router.back()
}

</script>

<template >
    <el-header>
        <!-- Header content -->
        <Navbar />
    </el-header>
    <el-row style="height: 100%;">
        <!-- 左側空白 -->
        <el-col :span="5" :offset="0"></el-col>
        <!-- 中間內容 -->
        <el-col :span="14" :offset="0" style="padding: 22px;">
            <div class="common-layout">
                <el-container direction="vertical">
                    <div v-for="data in datatype" :key="data.detailsId" style="width:100%; ;  ">
                        <el-header
                            style="font-size: 40px; border: 50px;    background-color: #303133 ; 
                                                                                                        padding:13px; height: 10%; font-size: 35px; color:#FAFAFA;  font-weight:bold;">
                            {{ data.eventName }}
                        </el-header>
                        <el-aside width="100%">
                            <div>
                                <img style="display:block; margin:auto; padding: 0px;" :src="imgurl + data.eventImage">
                            </div>
                        </el-aside>
                        <el-container>
                            <el-main
                                style="background-color: #f4f4f5; height:40%; padding: 30px; line-height: 1.8; font-size: 16px;">
                                <span>
                                    {{ data.reason }}
                                </span>
                                <el-row style="padding-top: 10%;">
                                    <el-col :span="10">
                                        <div></div>
                                    </el-col>
                                    <el-col :span="7">
                                        <div>
                                            <el-button type="primary" @click="goback()">返回</el-button>
                                        </div>
                                    </el-col>
                                    <el-col :span="7">
                                        <div></div>
                                    </el-col>
                                </el-row>
                                <div>
                                </div>
                            </el-main>
                        </el-container>
                    </div>
                </el-container>
            </div>
        </el-col>
        <!-- 右測空白 -->
        <el-col :span="5" :offset="0"> </el-col>
    </el-row>
    <footer>
        <Footer />
    </footer>
</template>

