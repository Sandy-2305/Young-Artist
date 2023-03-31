<script setup lang="ts">
import { ref, reactive, onMounted, onUnmounted } from 'vue'
import axios from 'axios';
import type { carouselInterface } from '@/types/carouselInterface'
import { useRouter } from 'vue-router';

// 由活動圖片轉跳活動頁面

const router = useRouter()
const getEventId = (EventId: number) => {
    router.push({ name: "EventDetailView", params: { eventId: EventId } })
}
//從wwwroot/Images/拿圖片
const url = ref("https://localhost:7165/Images/")

const carouselData = reactive<carouselInterface[]>([])

const carouselHeight = ref('')

const setCarouselHeight = (event: Event) => {
    const img = event.target as HTMLImageElement
    const height = Math.min(img.height)
    carouselHeight.value = `${height}px`

}

// const handleResize = () => {
//   const windowHeight = window.innerHeight
//   const height = Math.min(parseInt(carouselHeight.value), windowHeight)
//   carouselHeight.value = `${height}px`
// }


onMounted(async () => {
    //查詢某筆資料
    await axios.get('https://localhost:44393/api/Advertisements/Carousel')
        .then(response => {
            carouselData.splice(0, response.data.length, ...response.data)
            // console.log(carouselData);
            //獲取圖片高度
            const imgs = document.querySelectorAll('img')
            imgs.forEach(img => {
                img.addEventListener('load', setCarouselHeight)
            })
        }).catch(error => {
            console.log(error);
        })

    //     handleResize()
    //   window.addEventListener('resize', handleResize)

})

// onUnmounted(() => {
//   window.removeEventListener('resize', handleResize)
// })
</script>


<template>
    <el-carousel :interval="3000" arrow="always" :height="carouselHeight" indicator-position="outside">
        <el-carousel-item v-for="item in carouselData" :key="item">
            <el-row>
                <el-col>
                    <a>
                        <img :src="url + item.advertisementSrc" :alt="item.advertisementAlt" @load="setCarouselHeight"
                            @click="getEventId(item.eventId)">
                    </a>
                </el-col>
            </el-row>
        </el-carousel-item>
    </el-carousel>
</template>
  
<style scoped lang="less">
.el-col {
    text-align: center;

    img {
        // width: 100%;
        // height: 400px;
        // object-fit:cover; //調整圖片比例

        width: 100%;
        height: auto;
        object-fit: contain;
    }

}
</style>
