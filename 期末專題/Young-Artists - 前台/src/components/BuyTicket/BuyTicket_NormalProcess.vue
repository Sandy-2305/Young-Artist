<script setup lang="ts">
import { ref, reactive ,computed} from 'vue'

const props = defineProps(["processStep"])

</script>

<template>
    <el-row>
        <el-col :span="24">
            <ul id="processBox">
                <li :class="{ process_target:processStep==1,process_over:processStep>1 }" >選擇票種</li>
                <svg viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg" data-v-029747aa=""><path fill="currentColor" d="M384 192v640l384-320.064z"></path></svg>
                <!-- <li class="process">劃位</li> -->
                <li :class="{ process_target:processStep==2,process_over:processStep>2,process:processStep<2 }">填寫表單</li>
                <svg viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg" data-v-029747aa=""><path fill="currentColor" d="M384 192v640l384-320.064z"></path></svg>
                <li :class="{ process_target:processStep==3,process:processStep<3 }">取票繳費</li>
            </ul>
        </el-col>
    </el-row>
</template>

<style scoped lang="less">
// 目前流程
@Process-Target-Color : rgb(64, 158, 255);
@Process-Target-Border_Color : rgb(57, 144, 231);
@Process-Target-Text-Color : white;
// 目前流程-數字圖標


// 未選中流程
@Process-Color : rgb(238, 238, 238);
@Process-Border_Color : rgb(220, 220, 220);
@Process-Text-Color : rgb(203, 203, 203);
// 未選中流程-數字圖標
ul {
    padding-right: 40px;
}
.el-row {
    height: 10vh;
    align-items: center;

}

#processBox {
    display: flex;
    justify-content: center;
    height: 4vh;
    .process {
        display: flex;
        width: 30%;
        background-color: @Process-Color;
        color: @Process-Text-Color;
        border-radius: 5vh;
        border : solid @Process-Border_Color;
        justify-content: center;
        align-items: center;
    }
    .process_over {
        display: flex;
        width: 30%;
        background-color: @Process-Target-Color;
        color: @Process-Target-Text-Color;
        opacity: 0.5;
        border-radius: 5vh;
        border : solid @Process-Target-Border_Color;
        justify-content: center;
        align-items: center;
    }

    .process_target {
        display: flex;
        width: 30%;
        background-color: @Process-Target-Color;
        color: @Process-Target-Text-Color;
        border-radius: 5vh;
        border : solid @Process-Target-Border_Color;
        justify-content: center;
        align-items: center;
    }
}
</style>