<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import axios from 'axios';
import { EventStore } from '@/stores/EventStore';
import { Search } from '@element-plus/icons-vue'
import { StarFilled } from '@element-plus/icons-vue'

const Categorybar = async (eventTypeId: number) => {
    try {
        const response = await axios.get(`https://localhost:44393/api/Events/TypeId/${eventTypeId}`)
        EventStore().cardData.splice(0, EventStore().cardData.length, ...response.data)
        console.log(EventStore().cardData);

    } catch (error) {
        console.log(error)
    }
}

</script>
<template>
    <el-row>
        <el-col :span="1" :offset="0"></el-col>
        <el-col :span="22" :offset="0">
            <div>
                <el-divider content-position="center">探索活動</el-divider>
            </div>
            <ul>
                <div class="categorytext">
                    <el-button round>
                        <el-link :icon="Search" :underline="false" href="http://localhost:5173/">
                            所有活動
                        </el-link>
                    </el-button>
                </div>
                <div>
                    <el-button round @click="Categorybar(1)"><img
                            src="./images/microphone-part-2-svgrepo-com.svg">演唱會</el-button>
                </div>
                <div>
                    <el-button round @click="Categorybar(2)"><img src="./images/piano-svgrepo-com.svg">音樂會</el-button>
                </div>
                <div>
                    <el-button round @click="Categorybar(3)"><img src="./images/mask-svgrepo-com.svg">戲劇</el-button>
            </div>
            <div>
                    <el-button round @click="Categorybar(4)"><img src="./images/baseball-svgrepo-com.svg">運動</el-button>
                </div>
                <div>

                    <el-button round @click="Categorybar(5)"><img
                            src="./images/painting-palette-svgrepo-com.svg">動漫</el-button>
                </div>
                <div>

                    <el-button round @click="Categorybar(6)"><img src="./images/book-svgrepo-com.svg">講座</el-button>
                </div>
                <div>

                    <el-button round @click="Categorybar(7)"><img src="./images/suitcase-svgrepo-com.svg">旅遊</el-button>
                </div>
            </ul>
            <!-- <div>
                                           <el-divider content-position="center"></el-divider>
                                         </div> -->
        </el-col>
        <el-col :span="1" :offset="0"></el-col>
    </el-row>
</template>
<style scoped lang="less">
.categorytext {
    font-weight: bold;
    display: flex;
    justify-content: center;
    align-items: center;
}

.el-button {
    margin: 0 5px 5px 5px;
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.24), 0px 0px 2px rgba(0, 0, 0, 0.12);
    // background-color: gray;
    // color: white;
    font-weight: bold;
}

img {
    width: 1em;
    height: 1em;
    margin-right: 5px;
}

.categorybar {
    margin-bottom: 5px;
}

.el-link {
    margin-right: 8px;
}

.el-link .el-icon--right.el-icon {
    vertical-align: text-bottom;
}

.el-row {
    border: 1px solid rgb(224, 224, 224);

}

.el-col {
    ul {
        margin: 20px;
        padding: 0;
        width: 100%;
        display: flex;
        list-style-type: none;
        flex-wrap: wrap;
        justify-content: center;

    }
}
</style>