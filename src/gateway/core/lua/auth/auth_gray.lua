-- Tencent is pleased to support the open source community by making BK-CI 蓝鲸持续集成平台 available.
-- Copyright (C) 2019 THL A29 Limited, a Tencent company.  All rights reserved.
-- BK-CI 蓝鲸持续集成平台 is licensed under the MIT license.
-- A copy of the MIT License is included in this file.
-- Terms of the MIT License:
-- ---------------------------------------------------
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
-- documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
-- rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to the following conditions:
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of
-- the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
-- LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
-- NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
-- WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
local ns_config = nil
if ngx.var.devops_region ~= "DEVNET" then
    ns_config = config.ns
else
    ns_config = config.ns_devnet
end

local tag = tagUtil:get_tag(ns_config)
local isGray = grayUtil:get_gray()
if isGray or tag == "gray" then
    ngx.var.static_dir = config.static_dir_gray
    ngx.var.static_dir_codecc = config.static_dir_codecc_gray
    ngx.header["X-DEVOPS-GRAY"] = "true"
    ngx.header["X-DEVOPS-GRAY-DIR"] = "gray"
else
    ngx.var.static_dir = config.static_dir
    ngx.var.static_dir_codecc = config.static_dir_codecc
    ngx.header["X-DEVOPS-GRAY"] = "false"
    ngx.header["X-DEVOPS-GRAY-DIR"] = "prod"
end
ngx.exit(200)
