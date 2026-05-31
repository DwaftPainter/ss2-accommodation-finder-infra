FROM opensearchproject/data-prepper:2.15.0

# Chuyển sang quyền root để tạo thư mục và copy file
USER root

# Tạo thư mục cho plugin (nếu cần)
RUN mkdir -p /usr/share/data-prepper/plugins

# Copy driver Postgres vào cả 2 nơi để đảm bảo plugin nhận diện được
COPY postgresql-42.7.9.jar /usr/share/data-prepper/lib/
COPY postgresql-42.7.9.jar /usr/share/data-prepper/plugins/

# Trả lại quyền cho user mặc định (UID 1000)
USER 1000
