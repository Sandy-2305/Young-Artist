<script lang="ts" setup>
import { ref, reactive, onMounted } from "vue";


</script>

<template>
    <div data-v-938821b8="">

        <div class="l-footer">
            <footer class="l-footer-container col-container">
                <div class="service">

                    <img src="./images/boy-light-svgrepo-com.svg" style="width: 25px;">&nbsp;&nbsp;&nbsp;
                    <h1 style="display: inline;">聞意青年</h1>

                    <div class="column">
                        <div class="column hidden-md-and-down">
                            <ul class="links">
                                <h3 class="title" id="aboutMe">關於我們</h3>
                                <li><a href="#">品牌故事</a></li>
                                <li><a href="#">服務據點</a></li>
                                <li><a href="#">贊助廠商</a></li>
                            </ul>
                        </div>
                        <div class="column hidden-md-and-down">
                            <ul class="links">
                                <h3 class="title">客服資訊</h3>
                                <li><a href="#">常見問題</a></li>
                                <li><a href="#">使用條款</a></li>
                                <li><a href="#">聯絡我們</a></li>
                            </ul>
                        </div>
                        <div class="icon">
                            <a href="https://www.facebook.com/ispan.kaohsiung/"><i class="fa-brands fa-facebook icon"
                                    id="facebook"></i></a>
                            <a href="https://www.ispan.com.tw/"><i class="fa-brands fa-square-twitter icon"
                                    id="twitter"></i></a>
                            <a href="https://www.ispan.com.tw/IG"><i class="fa-brands fa-square-instagram icon"
                                    id="instagram"></i></a>
                            <a href="https://www.youtube.com/channel/UCObZbQQVeVvznp9TIPkqIPA"><i
                                    class="fa-brands fa-youtube icon" id="youtube"></i></a>
                            <a href="https://www.ispan.com.tw/OJT/DigitalMarketing/LINE"><i class="fa-brands fa-line icon"
                                    id="line"></i></a>
                        </div>
                    </div>
                </div>
                <div class="l-footer__copyright">
                    <p><span>
                            Copyright ©
                        </span> <span>免責聲明</span></p>
                    <div>本網站所載的所有資料、商標、標誌、圖像、短片、聲音檔案、連結及其他資料等僅供資展國際全端工程師課程專題使用，並不構成任何形式的商業活動。若有關於版權疑慮或其他相關問題，請聯繫
                        YoungArtist2023@gmail.com。
                    </div>
                </div>
            </footer> <!---->
        </div>
    </div>
</template>




<style scoped lang="less">
.l-footer {
    --swiper-theme-color: #007aff;
    --swiper-navigation-size: 44px;
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    border: 0;
    font: inherit;
    vertical-align: baseline;
    font-family: Helvetica, Arial, sans-serif;
    display: block;
    padding-top: 2rem;
    padding-bottom: 2rem;
    background: #d8d8d8;
    color: #000;
    width: 100%;
    text-align: left;
}

.column {
    color: #2a2a2a;
    --swiper-theme-color: #007aff;
    --swiper-navigation-size: 44px;
    text-align: center;
    box-sizing: border-box;
    margin-inline: 20px;
    padding: 0;
    border: 0;
    font: inherit;
    vertical-align: baseline;
    font-family: Helvetica, Arial, sans-serif;
    display: flex;
    text-decoration: none;
}

.l-footer-container {
    --swiper-theme-color: #007aff;
    --swiper-navigation-size: 44px;
    color: #000;
    text-align: left;
    box-sizing: border-box;
    padding: 0;
    border: 0;
    font: inherit;
    vertical-align: baseline;
    display: block;
    margin: 0 auto;
    max-width: 1415px;
    min-width: 0;
    padding-left: 1.8125rem;
    padding-right: 1.8125rem;
}

.service {
    font-size: 15px;
    line-height: 24px;
    box-sizing: border-box;
    padding: 0;
    margin: 0 auto;
    display: flex;
    justify-content: center;
    width: 100%;
    border: 0;
    flex-wrap: wrap;
    align-items: center;
}

.links {
    list-style: none;
    padding: 0;
    margin-bottom: 20px;
    margin-inline: 30px;
    font-size: 14px;
}

.title {
    margin-top: 0;
}

a {
    text-decoration: none;
    color: #424242;
}

.icon {
    color: rgb(77, 77, 78);
    font-size: 30px;
    margin-inline: 10px;
    margin-block: 30px;
}

#facebook:hover {
    color: rgb(56, 82, 154);
}

#twitter:hover {
    color: rgb(77, 166, 233);
}

#instagram:hover {
    color: rgb(182, 47, 110);
}

#youtube:hover {
    color: rgb(247, 0, 0);
}

#line:hover {
    color: rgb(6, 193, 82);
}

.l-footer__copyright {
    --swiper-theme-color: #007aff;
    --swiper-navigation-size: 44px;
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    border: 0;
    font: inherit;
    vertical-align: baseline;
    font-family: Helvetica, Arial, sans-serif;
    display: block;
    font-size: .75rem;
    letter-spacing: .23px;
    color: #000;
    text-align: center;
    margin-top: 1.5625rem;
}
</style>