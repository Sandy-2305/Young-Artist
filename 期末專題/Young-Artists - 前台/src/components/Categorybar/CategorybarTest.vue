<script setup lang="ts">

</script>
<template>
    <el-row>
        <el-col :span="5" :offset="0"></el-col>
        <el-col :span="14" :offset="0">
            <ul>
                <li id="li-none-border">
                    <p>依興趣找活動</p>
                </li>
                <li>
                    <div class="flex-box">
                        <div class="sprite sprite1"></div>
                    </div>
                    <p><a href="#">聯誼</a></p>
                </li>
                <li>
                    <div class="flex-box">
                        <div class="sprite sprite2"></div>
                    </div>
                    <p><a href="#">美食</a></p>
                </li>
                <li>
                    <div class="flex-box">

                        <div class="sprite sprite3"></div>
                    </div>
                    <p><a href="#">學習</a></p>
                </li>
                <li>
                    <div class="flex-box">

                        <div class="sprite sprite4"></div>
                    </div>
                    <p><a href="#">戶外</a></p>
                </li>
                <li>
                    <div class="flex-box">

                        <div class="sprite sprite5"></div>
                    </div>
                    <p><a href="#">展覽</a></p>
                </li>
                <li>
                    <div class="flex-box">

                        <div class="sprite sprite6"></div>
                    </div>
                    <p><a href="#">演出</a></p>
                </li>
                <li id="li-moreCategory">
                    <p><a href="#">更多分類>></a></p>
                </li>
            </ul>
        </el-col>
        <el-col :span="5" :offset="0"></el-col>
    </el-row>
</template>
<style scoped lang="less">
.el-row {
    border: 1px solid rgb(224, 224, 224);

}

.el-col {
    ul {
        margin: 0;
        padding: 0;
        width: 100%;
        display: flex;
        list-style-type: none;
        justify-content: space-between;

        li {
            text-align: center;
            border-left: 1px solid rgb(224, 224, 224);
            flex: 1;
            display: f;
            padding:1% 0;
            .flex-box {
                display: flex;
                justify-content: center;
            }

            p {
                a {
                    text-decoration: none;
                    color: rgb(153, 153, 153);
                }
            }
        }

        li:hover {
            .sprite {
                background-position: 0 -704px;
            }

            a {
                color: black;
            }
        }

        #li-none-border {
            border-left: 0px;
        }

        #li-moreCategory {
            a {
                color: rgb(100, 192, 96);
            }

            a:hover {
                color: rgb(78, 149, 29)
            }
        }
    }
}




.sprite {
    width: 64px;
    height: 64px;
    background-repeat: no-repeat;
    background-position: 0 0;
    transition: background-position 0.3s steps(11);
}

.sprite1 {
    background-image: url('./images/category-cupid-46c3bd8f8a8a1a0e88b6df2e4299f6a8dce6e6f4b171a9eb0015dad7d53964f9.svg');
}

.sprite2 {
    background-image: url('./images/category-food-c65d7d561efc09547ee5f18b1b2c8b1f6a1275a2553a85545c27e67d764d1cb8.svg');
}

.sprite3 {
    background-image: url('./images/category-globe-3dfaa04bffeea8160d7353864b44e31e6ea6eb974486b1d86bb4005024519ee6.svg');
}

.sprite4 {
    background-image: url('./images/category-outdoor-5ba5d4155c0b57f9c08589788f3d489a4c86d0729ab05e57034766ad19564d2e.svg');
}

.sprite5 {
    background-image: url('./images/category-painting-25e28eaf05d4d4b4161a8e740bfd63e008dbbe57982dc8c0f29a23976b1d4a55.svg');
}

.sprite6 {
    background-image: url('./images/category-rock-983b9497dc77002d548018fcde66cfcf03dd8a61f7a0f6ba330120f690f33326.svg');
}</style>