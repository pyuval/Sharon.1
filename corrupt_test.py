# corrupt_test.py
from scapy.all import rdpcap, wrpcap, Raw

pkts = rdpcap('bus_defs/10hz.pcap')
p = pkts[0]

raw = bytearray(bytes(p['UDP'].payload))
print('before, offset 2 (NUMDATA_10HZ):', raw[2])
raw[2] = 50  # was 72 -- this is a fixed constant per the ICD, so this must fail validation

p['UDP'].remove_payload()
p = p / Raw(bytes(raw))
del p['UDP'].chksum   # let scapy recompute checksums for the modified payload
del p['IP'].len
del p['IP'].chksum

wrpcap('bus_defs/10hz_corrupted.pcap', p)
print('after, offset 2:', raw[2])
print('wrote bus_defs/10hz_corrupted.pcap')