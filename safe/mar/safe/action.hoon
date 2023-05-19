/-  *safe
|_  act=action
++  grab
  |%
  ++  noun  action
  ++  json
    =,  dejs:format
    |=  jon=json
    %-  action
    =<  (fe-action jon)
    |%
    ++  fe-action
      %-  of
      :~  [%addedsafes (om (om parse-added-safes))]
          [%addressbook (om (om so))]
          [%cookies parse-cookies]
          [%ownedsafes (om (om (ar so)))]
          [%session parse-session]
          [%settings parse-settings]
          [%fe-test ul]
      ==
    ++  parse-settings
      %-  ot
      :~  [%currency so]
          [%'shortName' parse-shortname]
          [%theme (om bo)]
      ==
    ++  parse-shortname
      %-  ot
      :~  [%show bo]
          [%copy bo]
          [%qr bo]
      ==
    ++  parse-cookies
      %-  ot
      :~  [%updates bo]
          [%necessary bo]
          [%analytics bo]
      ==
    ++  parse-added-safes
      %-  ot
      :~  [%threshold ni]
          [%'ethBalance' so]
          [%owners (ar (ot ~[[%value so]]))]
      ==
    ++  parse-session
      %-  ot
      :~  [%'lastChainId' so]
          [%'lastSafeAddress' (om so)]
      ==
    --
  --
++  grow
  |%
  ++  noun  act
  --
++  grad  %noun
--
