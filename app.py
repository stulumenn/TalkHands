import subprocess
import os
from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename

app = Flask(__name__)

# Yükleme klasörünü belirle
UPLOAD_FOLDER = 'uploads/'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

ALLOWED_EXTENSIONS = {'jpg', 'jpeg', 'png'}

# Dosya formatını kontrol etmek için yardımcı fonksiyon
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/detect', methods=['POST'])
def detect():
    if 'image' not in request.files:
        return jsonify({'error': 'No image file part'}), 400

    file = request.files['image']

    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    if file and allowed_file(file.filename):
        # Dosya adı ve yolu
        filename = secure_filename(file.filename)
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)

        # Dosyayı kaydet
        file.save(file_path)

        # YOLO modelini çalıştır
        result = run_yolo_detect(file_path)

        # Tespit sonuçlarını döndür
        return jsonify(result)

    return jsonify({'error': 'Invalid file format'}), 400

# YOLO modelini çalıştıran fonksiyon
def run_yolo_detect(image_path):
    # Detect.py dosyasının yolunu dinamik olarak ayarlayın
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))
    yolov5_dir = os.path.join(BASE_DIR, "yolo-gesture-detection/yolov5")  # Yolov5 dizinini kök dizinden başlatarak alıyoruz
    detect_script = os.path.join(yolov5_dir, "detect.py")  # detect.py dosyasının tam yolu

    if not os.path.exists(detect_script):
        return {"error": f"detect.py script not found at {detect_script}"}

    command = [
        "python", detect_script,  # detect.py dosyasının doğru yolu
        "--weights", "yolov5s.pt",  # Kendi modelinizi buraya ekleyin
        "--source", image_path,
        "--conf-thres", "0.4",  # Güven eşiği
        "--save-txt",  # Çıktıyı dosyaya kaydetme
        "--save-conf", # Güven oranını kaydetme
    ]

    # subprocess ile komutu çalıştır ve çıktıyı al
    result = subprocess.run(command, capture_output=True, text=True)

    # Eğer model başarılı bir şekilde çalıştıysa
    if result.returncode == 0:
        # Çıktıyı analiz et
        detections = extract_detections(result.stdout)
        return detections
    else:
        return {"error": result.stderr}

# Modelin çıktısını işleyip tespit edilen nesneleri döndüren fonksiyon
def extract_detections(output):
    detections = output
    return {
        "detections": detections,
        "message": "Objects detected successfully"
    }


if __name__ == '__main__':
    # Uygulamayı başlat
    if not os.path.exists(UPLOAD_FOLDER):
        os.makedirs(UPLOAD_FOLDER)
    app.run(host='0.0.0.0', port=5001)
