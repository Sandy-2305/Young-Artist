﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace Young_Artist_Server.Models
{
    public partial class Commodity
    {
        public int Id { get; set; }
        public string CommodityName { get; set; }
        public string CommodityNarrative { get; set; }
        public int? CommodityNum { get; set; }
        public decimal? CommodityPrice { get; set; }
        public string CommodityImage { get; set; }
        public string CommodityStart { get; set; }
        public int? CommoditySort { get; set; }
        public int? CommoditySale { get; set; }
        public string CommodityClassification { get; set; }
        public bool? CommodityState { get; set; }
    }
}