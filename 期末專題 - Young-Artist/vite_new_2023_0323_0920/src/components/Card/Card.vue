<script setup lang="ts">

</script>

<template>
    <el-row id="topic">
        <el-col :span="5" :offset="0"></el-col>
        <el-col :span="14" :offset="0">
            <h1 id="myEvent">精彩活動</h1>
        </el-col>
        <el-col :span="5" :offset="0"></el-col>
    </el-row>

    <el-row>
        <el-col :span="5"></el-col>
        <el-col :span="14" id="CardBar">
            <el-col v-for="(o, index) in 12" :key="o" :span="5">
                <el-card :body-style="{ padding: '3px' }">
                    <img src="https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png"
                        class="image" />
                    <div style="padding: 3px">
                        <div>演唱會</div>
                        <div>2023/10/10 ~ 2023/12/01</div>
                        <div class="bottom">
                            <el-button text class="button">詳細</el-button>
                        </div>
                    </div>
                </el-card>
            </el-col>
        </el-col>
        <el-col :span="5"></el-col>
    </el-row>
</template>
  
  <script lang="ts" setup>
  import { ref } from 'vue'
  

  </script>
  
<style lang="less">
#topic {
    padding-top: 1%;
    padding-bottom: 1%;

    h1 {
        text-align: center;
    }
}

#CardBar {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;

    .el-card {
        margin-bottom: 10%;
    }
}

.bottom {
    margin-top: 13px;
    line-height: 12px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.button {
    padding: 0;
    min-height: auto;
}

.image {
    width: 100%;
    display: block;
}
</style>
  