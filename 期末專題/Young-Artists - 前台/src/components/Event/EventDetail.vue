<template>
  <el-row style="margin-top: 40px;">
    <el-col :span="5" :offset="0"></el-col>
    <el-col :span="14" :offset="0">
      <div>
        <el-row>
          <el-card v-for="(item, index) in EventData" :key="item" shadow="never" class="imagebox">
            <img :src="ImageUrl + item.eventImage" class="image">
          </el-card>
          <el-card v-for="(item, index) in EventData" :key="item" shadow="never" class="infobox">
            <div style="padding: 5px; height: 380px;">
              <div fonts style="padding: 7px;font-size:xx-large; font-style:inherit;">{{ item.eventName }}</div>
              <el-row>
                <div fonts style="padding: 7px;font-size:large;">活動類別：</div>
                <div fonts style="padding: 7px;font-size:large;">{{ item.eventTypeName }}</div>
              </el-row>
              <el-row>
                <div fonts style="padding: 7px;font-size:large;">活動地點：</div>
                <div fonts style="padding: 7px;font-size:large;">{{ item.eventLocationName }}</div>
              </el-row>
              <el-row>
                <div fonts style="padding: 7px;font-size:large;">主辦單位：</div>
                <div fonts style="padding: 7px;font-size:large;">{{ item.companyName }}</div>
              </el-row>
              <el-row>
                <div style="padding: 9PX;">
                  <i class="fa-regular fa-calendar-days"></i>
                </div>
                <div style="padding: 7PX;">活動售票時間：</div>
                <div style="padding: 7PX;">{{ item.eventSellStartTimestamp }} ~ {{ item.eventSellEndTimestamp }}</div>
              </el-row>
              <el-row>
                <div style="padding: 9PX;">
                  <i class="fa-regular fa-calendar-days"></i>
                </div>
                <div style="padding: 7PX;">活動舉辦時間：</div>
                <div style="padding: 7PX;">{{ item.eventStartTimestamp }} ~ {{ item.eventEndTimestamp }}</div>
              </el-row>

            </div>

          </el-card>
        </el-row>
      </div>
    </el-col>

    <el-col :span="5" :offset="0"></el-col>
  </el-row>

  <el-row>
    <el-col :span="5" :offset="0"></el-col>
    <el-col :span="14" :offset="0">
      <div>
        <span>
          <el-button id="InfoButton" type="primary" plain class="button" @click=TicketInfo>
            <div fonts style="margin: 10px;font-size:large;">
              <i class="fa-solid fa-circle-info"></i>
              購票資訊
            </div>
          </el-button>
        </span>
        <span>
          <el-button id="LocationButton" type="primary" plain class="button" @click=LocationInfo>
            <div fonts style="margin: 10px;font-size:large;">
              <i class="fa-solid fa-location-dot"></i>
              場地簡介
            </div>
          </el-button>
        </span>
        <span>
          <el-button id="CollectButton" type="primary" plain class="button" @click=Collect(EventData[0].eventId)>
            <div fonts style="margin: 10px;font-size:large;">
              <i class="fa-solid fa-bookmark"></i>
              收藏活動
            </div>
          </el-button>
        </span>
      </div>
    </el-col>
    <el-col :span="5" :offset="0"></el-col>
  </el-row>
  <el-row id="EventDetail" v-for="(item, index) in EventData" :key="item" style="margin: 20px;" value="">
    <el-col :span=5></el-col>
    <el-col :span=14>
      <div fonts style="font-size:x-large;margin-right: 3px;" id="TicketInfo">
        <i class="fa-solid fa-circle-info"></i>
        購票資訊
      </div>
      <hr />
      <br>
      <div>{{ item.eventInfo }}</div>
      <br>
      <div>
        <img :src="ImageUrl + item.eventImage" class="InfoImg">
      </div>
      <div>
        <el-button type="primary" plain class="button" style="margin: 20px;" @click="getEventId(item.eventId)">
          <div fonts style="margin: 10px;padding: 10px ;font-size:x-large;">
            <i class="fa-solid fa-ticket" style="margin: 10px;"></i>
            購買門票
          </div>
        </el-button>
      </div>
      <br>
      <div fonts style="font-size:x-large;" id="LocationInfo">
        <i class="fa-solid fa-map-location-dot"></i>
        場地簡介
      </div>
      <hr />
      <br>
      <div>場地名稱：{{ item.eventLocationName }}</div>
      <br>
      <div>場地地址：{{ item.eventLocationAddress }}</div>
      <br>
      <div>場地介紹：{{ item.eventLocationInfo }}</div>
      <br>
      <div>
        <img :src="ImageUrl + item.eventLocationImage" class="InfoImg">
      </div>
    </el-col>
    <el-col :span=5></el-col>
  </el-row>
  <el-row>
    <el-col :span=5></el-col>
    <el-col :span=14>
      <el-button type="primary" plain class="button" style="margin: 20px;" @click=getMap()>
        <div fonts style="margin: 10px;padding: 10px ;font-size:x-large;">
          <i class="fa-solid fa-map" style="margin: 10px;"></i>
          查看地圖
        </div>
      </el-button>
      <div class="mapContainer" ref="mapContainer" v-show="isMap"></div>
    </el-col>
    <el-col :span=5></el-col>
  </el-row>
</template>
  
<script lang="ts" setup>
import axios from 'axios';
import { reactive, onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { useRoute } from 'vue-router';
import { CustomerStore } from '@/stores/CustomerStore'
import type { eventInterface } from '@/types/EventInterface';
import L from "leaflet";
import "leaflet/dist/leaflet.css";
import "leaflet-control-geocoder/dist/Control.Geocoder.css";
import "leaflet-control-geocoder/dist/Control.Geocoder.js";
const router = useRouter()
const route = useRoute()
const customerData = CustomerStore().customerData
let mapContainer = ref(null);
let activeName = ref('ticketinfo')
const EventUrl = 'https://localhost:44393/api/Events/Id/'
const ImageUrl = "https://localhost:7165/Images/"
const EventData = reactive<eventInterface[]>([])
let isMap = ref(false)

const getEventId = (EventId: number) => {


  router.push({ name: "BuyTicketView", params: { eventId: EventId } })
}

const TicketInfo = () => {
  let TicketInfo = document.getElementById("TicketInfo");
  console.log(TicketInfo);
  TicketInfo.scrollIntoView({ behavior: 'smooth' }, true);
}
const LocationInfo = () => {
  let LocationInfo = document.getElementById("LocationInfo");
  console.log(LocationInfo);
  LocationInfo.scrollIntoView({ behavior: 'smooth' }, true);
}


const Collect = async (EventId: number) => {
  try {
    const response = await axios.post(`https://localhost:44393/api/EventCollects/Collect?customerid=${customerData[0].customerId}&eventid=${EventId}`)
    alert(response.data);
  } catch (error) {
    alert("請先登入")
    router.push('/CustomerView')
  }
}

const getMap = () => {
  isMap.value = !isMap.value;
  const map = L.map(mapContainer.value);
  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
  }).addTo(map);
  const address = EventData[0].eventLocationName;
  const geocoder = L.Control.Geocoder.nominatim();
  geocoder.geocode(address, (results: any) => {
    const latlng = results[0].center;
    const marker = L.marker(latlng).addTo(map);
    map.setView(latlng, 18);
  });
  geocoder.addTo(map);

}

onMounted(async () => {
  const eventId = route.params.eventId;
  await axios.get(`${EventUrl}${eventId}`)
    .then(response => {
      console.log(response.data);
      EventData.splice(0, response.data.length, ...response.data)
    })
    .catch(error => {
      console.log(error);
    })
  window.scrollTo(0, 0)

})

</script>
  
<style scoped>
.button {
  padding: 7PX;
  margin: 3px;
  min-height: auto;
}

.imagebox {
  overflow: hidden;
  width: 360px;
  height: auto;
  border: none;
  margin: 10px;
}

.image {
  height: 400px;
  margin-left: -50%;
  width: auto;
}

.infobox {
  width: 490px;
  border: none;
}

.InfoImg {
  width: 100%;
  height: auto;
}

.mapContainer {
  width: 100%;
  height: 500px;
  margin: 20PX;
}
</style>

