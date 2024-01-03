## usage

```bash
docker compose build
docker compose up -d
docker attach Kuberneteslab-terraform-1

make init
make construct
make setup-ansible
make setup-kubernetes

make show-nodes
make show-pods
make run-helloworld

make clean
```

- [](https://v1-27.docs.kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
- [](https://github.com/torgeirl/kubernetes-playbooks)


## Kubernetes初心者向け:AWSを活用したコンテナ入門ハンズオン手順を作ってみた

- [Qiita : Kubernetes初心者向け:AWSを活用したコンテナ入門ハンズオン手順を作ってみた](https://qiita.com/minorun365/items/0441e4878f0984a9fc0a)

メモ

- かなりメモリを消費する。動作が重くなることを承知でswapfileを作っておいたほうがいい
- `kubectl get pods -w`でウォッチモード。変更のあったpodが表示される。ctrl-cで終了
- `kubectl exec -it 〜 -- bash`でコンテナ内のbashを起動してデバッグすることが可能
- `kubectl delete pod [podname]`でpodを削除
- `kubectl apply -f [filename]`でyamlに書かれたリソース(podとかreplicasetとかservice)を生成する
- replicasetはdeploymentの下位互換
  - 「独自のアップデートオーケストレーションやアップデートを全く必要としない時以外はdeploymentを使用する」

## 〜ハンズオン手順で作成したのと同じ構成をhelmで試してみる

- [[Kubernetes / Helm] Helm Chart作成おためし (Getting StartedとNginx Pod作成)](https://zaki-hmkc.hatenablog.com/entry/2020/09/14/211500)
  - うまく行かない？
    - deploymentが`(0/1)`のままでPodが起動しない
      - [ServiceAccountについて理解する](https://amateur-engineer-blog.com/kubernetes-service-account/)
        - サービスアカウントがないからPodが起動しないっぽい
      - template/serviceaccount.yamlまで削除したのが良くないと思われる？
  - `helm lint`でlintしてから`helm package`でパッケージ化する
