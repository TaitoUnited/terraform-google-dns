/**
 * Copyright 2021 Taito United
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "google_dns_managed_zone" "dns_zone" {
  for_each      = {for item in local.dnsZones: item.name => item}

  name          = each.value.name
  dns_name      = each.value.dnsName
  visibility    = each.value.visibility

  dnssec_config {
    state       = coalesce(each.value.dnssec.state, "off")
  }
}

resource "google_dns_record_set" "dns_record_set" {
  depends_on    = [google_dns_managed_zone.dns_zone]
  for_each      = {for item in local.dnsZoneRecordSets: item.key => item}

  name = each.value.dnsName
  type = each.value.type
  ttl  = each.value.ttl

  managed_zone  = each.value.dnsZone.name

  rrdatas       = each.value.values
}
