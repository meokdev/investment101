from flask import Flask, request, jsonify
import os

app = Flask(__name__)

@app.route('/get_data', methods=['GET'])
def get_data():
    # Retrieving parameters from the GET request
    unit = request.args.get('unit', type=int)
    type_ = request.args.get('type', type=str)  # type is either 'Question' or 'article'

    # Constructing the file path
    file_path = os.path.join('data', type_, f'unit{unit}{type_}.txt')

    # Attempt to open and read the file
    try:
        with open(file_path, 'r') as file:
            content = file.read()
        response = {'status': 'success', 'content': content}
    except FileNotFoundError:
        response = {'status': 'error', 'message': 'File not found'}
    except Exception as e:
        response = {'status': 'error', 'message': str(e)}

    # Returning the response. Adjust the response structure as needed for your application.
    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
