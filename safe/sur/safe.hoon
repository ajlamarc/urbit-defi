|%
+$  chain-id  @t
+$  address  @t
+$  name  @t
::
+$  cookies  [updates=? necessary=? analytics=?]
+$  session  [@t (map chain-id address)]
::
+$  safes  
  (map chain-id (map address=@t safe-contents))
::
+$  safe-contents  
  [threshold=@ud ethbalance=@t owners=(list address=@t)]
::
+$  address-book  (map chain-id (map address name))
::
+$  owned-safes  
  (map address (map chain-id (list address)))
::
+$  settings
  [currency=@t shortname=[copy=? qr=? show=?] theme=(map @t ?)]
::
+$  pending-txs  (map @t @t)
::
+$  safe-apps  (map @t @t)
::
+$  safe
  $:  address=@t
      name=@t
      owners=(list [address=@t name=@t])
  ==
::
+$  action
    $%  [%addedsafes safes]
        [%addressbook address-book]
        [%cookies cookies]
        [%ownedsafes owned-safes]
        [%session session]
        [%settings settings]
        [%fe-test ~]
    ==
::
+$  update
    $%  [%test-num num=@ud]
    ==
--