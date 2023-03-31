<script setup lang="ts">

</script>

<template>
    <RouterView />
</template>

<style  lang="less">
@TestColor: rgb(209, 209, 209);
@NavbarColor: rgb(100, 192, 37);


body {
    height: 100%;
    margin: 0;
    padding: 0;

    @media screen and (max-width:768px) {
        &.scroll-bar {
            overflow-y: auto;
            overflow-x: auto;

        }

        &.scroll-bar::-webkit-scrollbar {
            width: 5px;
            height: 8px;
            background-color: #aaa;
        }

        &.scroll-bar::-webkit-scrollbar-thumb {
            border-radius: 3px;
            background: rgba(0, 0, 0, 0.25);
        }
    }

}

.el-container {
    width: 100%;
    height: 100%;

    .el-header {
        width: 100%;
        height: 100%;
        padding: 0;
        background-color: @TestColor;        
    }

    .el-main {
        padding: 0;
        height: 100%;
        width: 100%;
    }

    .el-footer {
        padding: 0;
        height: 100%;
        width: 100%;
    }
}
</style>