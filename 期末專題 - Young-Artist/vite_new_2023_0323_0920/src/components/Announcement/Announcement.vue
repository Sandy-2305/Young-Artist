<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import axios from 'axios';
import { useRoute } from 'vue-router';

const route = useRoute()
const ChangeAnnouncement = route.params


//引入資料庫資料
const url = ref('https://localhost:44393/api/Announcements')
interface datatype {
    aid: number,
    announcementType: string,
    content: string,
    contentTime: string,
    contentTitle: string,
    detailsId: number,

}
onMounted(() => {
    axios
        .get(`${url.value}`)
        .then(response => {
            console.log(response.data)
            datas.splice(0, response.data.length, ...response.data)
        })
        .catch(error => {
            console.log(error)
        })
});

const datas = reactive<datatype[]>([])
//摺疊欄位
const activeName = ref('1')
</script>

<template>
    <el-row>
        <!-- 左側空白 -->
        <el-col :span="5" :offset="0"></el-col>
        <!-- 中間內容 -->
        <el-col :span="14" :offset="0">
            <div class="demo-collapse">
                <el-collapse v-for="data in datas" :key="data.aid" accordion>
                    <el-collapse-item
                        :title="`【${data.announcementType}】${data.contentTitle}`"
                        name="1" border-style="dashed">
                        <div>
                            {{data.contentTime}}
                        </div>
                        <br>
                        <div>
                            {{ data.content }}
                        </div>
                    </el-collapse-item>
                </el-collapse>
                <div id="linkbox">
                    <el-link type="primary">
                        <RouterLink to="/AnnouncementChange" style="text-decoration: none;text-decoration:none;">活動異動公告一覽表
                        </RouterLink>
                    </el-link>
                </div>
            </div>
        </el-col>
        <!-- 右側空白 -->
        <el-col :span="5" :offset="0"></el-col>
    </el-row>
</template>


<style scoped lang="less">
.el-link {
    margin-right: 8px;
}

.el-link .el-icon--right.el-icon {
    vertical-align: text-bottom;
}
</style>