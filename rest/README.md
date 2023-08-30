# 

## install
> mix archive.install hex phx_new
 generate
> mix phx.new ledger --no-html --database mysql --binary-id

> mix phx.gen.json Control Account accounts account:integer amount:decimal org:string 

curl --location 'localhost:4000/api/accounts' \
--header 'Content-Type: application/json' \
--data '{
    "account": {
        "org": "tn-x",
        "account": 1,
        "amount": 200.20
    }
}'