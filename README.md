# Inception

## nginx

O Nginx (pronunciado como "Engine-X") é um servidor web e proxy reverso de alto desempenho, usado para servir páginas da web, balancear carga e atuar como um cache ou proxy para outras aplicações.

O Nginx está na rede inception, permitindo que ele se comunique com outros serviços (WordPress, MariaDB, etc.).

### 🔍 O Que é um Proxy?

Um proxy é um intermediário entre um cliente (como um navegador) e um servidor de destino. Ele recebe requisições do cliente, processa essas requisições e, em seguida, as encaminha para o servidor real. O servidor responde ao proxy, que então repassa a resposta para o cliente.

➡ Resumindo: um proxy age como um "mensageiro" entre o usuário e o destino final.
📌 Tipos de Proxy

Os proxies podem ser usados para diferentes finalidades. Aqui estão os mais comuns:
1️⃣ Proxy Normal (Forward Proxy)

    Fica entre o cliente e a internet.
    Normalmente usado para esconder o IP do cliente ou filtrar conteúdos.

🔹 Exemplo de uso:

    Empresas podem usar proxies para bloquear sites não permitidos.
    Usuários podem usar proxies para acessar conteúdos bloqueados geograficamente.

📌 Exemplo: Um proxy configurado no navegador pode interceptar todo o tráfego antes de ele sair para a internet.
2️⃣ Proxy Reverso (Reverse Proxy)

    Fica entre os clientes e os servidores.
    O cliente faz requisições ao proxy, que as repassa ao servidor real.
    O servidor real nunca é exposto diretamente ao cliente.

🔹 Exemplo de uso:

    Segurança: Esconde a infraestrutura real do servidor.
    Balanceamento de carga: Distribui requisições entre vários servidores para evitar sobrecarga.
    Cache: Pode armazenar respostas para acelerar as requisições seguintes.

📌 O Nginx está sendo usado como um reverse proxy!

Exemplo de configuração do Nginx como proxy reverso para um servidor WordPress:

server {
    listen 443 ssl;
    server_name example.com;

    ssl_certificate /etc/nginx/ssl/nginx.crt;
    ssl_certificate_key /etc/nginx/ssl/nginx.key;

    location / {
        proxy_pass http://wordpress:80;
    }
}

🔹 O Nginx recebe as requisições e redireciona para o WordPress, sem expor diretamente o servidor do WordPress ao usuário.
🎯 Benefícios de um Proxy Reverso como o Nginx

✅ Segurança: Protege o servidor real de ataques diretos.
✅ Performance: Pode fazer cache e compressão de arquivos.
✅ Balanceamento de Carga: Divide requisições entre vários servidores.
✅ Gerenciamento de Tráfego: Pode bloquear acessos indesejados.