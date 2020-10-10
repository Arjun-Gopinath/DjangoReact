import React, { Component, useState } from 'react'
import './css/Update.css'
import axios from 'axios'
import Cookies from 'js-cookie'

import { makeStyles } from '@material-ui/core/styles';

import IconButton from '@material-ui/core/IconButton';
import RemoveIcon from '@material-ui/icons/Remove';
import AddIcon from '@material-ui/icons/Add';
import Container from '@material-ui/core/Container';
import TextField from '@material-ui/core/TextField';
import Button from '@material-ui/core/Button';

// CSRF Token for forms *Don't Delete*
var csrftoken = Cookies.get('csrftoken');

const useStyles = makeStyles((theme) => ({
    root: {
        '& .MuiTextField-root': {
            margin: theme.spacing(1),
        },
    },
    button: {
        margin: theme.spacing(1),
    }
}))

// Title Function

var Tcount = 1;
var sendTitles = [];

function Title() {
    const classes = useStyles()
    const [titles, setTitles] = useState([
        { title: '' },
    ]);

    const handleSubmit = (e) => {
        e.preventDefault();
        sendTitles = titles;
        console.log(sendTitles);
        // console.log("titles", titles[0]['title']);
    };

    const handleChangeInput = (index, event) => {
        const values = [...titles];
        values[index][event.target.name] = event.target.value;
        setTitles(values);
    }

    const handleAddFields = () => {
        Tcount += 1;
        setTitles([...titles, { title: '' }]);
    }

    const handleRemoveFields = (index) => {
        if (Tcount > 1) {
            const values = [...titles];
            values.splice(index, 1);
            setTitles(values);
            Tcount -= 1;
        }
    }

    return (
        <Container>
            <form className={classes.root} onSubmit={handleSubmit}>
                {titles.map((inputField, index) => (
                    <div key={index}>
                        <TextField
                            name="title"
                            label="Title"
                            variant="filled"
                            value={inputField.title}
                            onChange={event => handleChangeInput(index, event)}
                        />
                        <IconButton
                            onClick={() => handleRemoveFields(index)}
                        >
                            <RemoveIcon />
                        </IconButton>
                        <IconButton
                            onClick={() => handleAddFields()}
                        >
                            <AddIcon />
                        </IconButton>
                    </div>
                ))}
                <Button
                    className={classes.button}
                    variant="contained"
                    color="primary"
                    type="submit"
                    onClick={e => handleSubmit(e)}
                >Set Title</Button>
            </form>
        </Container>
    );
}

// Text function

var Tecount = 1;
var sendTexts = [];

function Text() {
    const classes = useStyles()
    const [texts, setTexts] = useState([
        { text: '' },
    ]);

    const handleSubmit = (e) => {
        e.preventDefault();
        sendTexts = texts;
        console.log(sendTexts);
        // console.log("texts", texts[0]['title']);
    };

    const handleChangeInput = (index, event) => {
        const values = [...texts];
        values[index][event.target.name] = event.target.value;
        setTexts(values);
    }

    const handleAddFields = () => {
        Tecount += 1;
        setTexts([...texts, { text: '' }])
    }

    const handleRemoveFields = (index) => {
        if (Tecount > 1) {
            const values = [...texts];
            values.splice(index, 1);
            setTexts(values);
            Tecount -= 1;
        }
    }

    return (
        <Container>
            <form className={classes.root}>
                {texts.map((inputField, index) => (
                    <div key={index}>
                        <TextField
                            name="text"
                            label="Text"
                            variant="filled"
                            value={inputField.text}
                            onChange={event => handleChangeInput(index, event)}
                        />
                        <IconButton
                            onClick={() => handleRemoveFields(index)}
                        >
                            <RemoveIcon />
                        </IconButton>
                        <IconButton
                            onClick={() => handleAddFields()}
                        >
                            <AddIcon />
                        </IconButton>
                    </div>
                ))}
                <Button
                    className={classes.button}
                    variant="contained"
                    color="primary"
                    type="submit"
                    onClick={handleSubmit}
                >Set Texts</Button>
            </form>
        </Container>
    );
}

// Icons Function

var Icount = 1;
var sendIcons = [];

function Icons() {
    const classes = useStyles()
    const [icons, setIcons] = useState([
        { icon: '' },
    ]);

    const handleSubmit = (e) => {
        e.preventDefault();
        sendIcons = icons
        console.log(sendIcons);
        // console.log("icons", icons[0]['icon']);
    };

    const handleChangeInput = (index, event) => {
        const values = [...icons];
        values[index][event.target.name] = event.target.value;
        setIcons(values);
    }

    const handleAddFields = () => {
        setIcons([...icons, { icon: '' }]);
        Icount += 1;
    }

    const handleRemoveFields = (index) => {
        if (Icount > 1) {
            const values = [...icons];
            values.splice(index, 1);
            setIcons(values);
            Icount -= 1;
        }
    }

    return (
        <Container>
            <form className={classes.root} onSubmit={handleSubmit}>
                {icons.map((icon, index) => (
                    <div key={index}>
                        <TextField
                            name="icon"
                            label="Icon"
                            variant="filled"
                            value={icon.icon}
                            onChange={event => handleChangeInput(index, event)}
                        />
                        <IconButton
                            onClick={() => handleRemoveFields(index)}
                        >
                            <RemoveIcon />
                        </IconButton>
                        <IconButton
                            onClick={() => handleAddFields()}
                        >
                            <AddIcon />
                        </IconButton>
                    </div>
                ))}
                <Button
                    className={classes.button}
                    variant="contained"
                    color="primary"
                    type="submit"
                    onClick={handleSubmit}
                >Set Icons</Button>
            </form>
        </Container>
    );
}


// Update Class

export default class Update extends Component {
    constructor(props) {
        super(props);
        this.state = {
            title: sendTitles,
            pos: '',
            icon: sendIcons,
            colour: '',
            text: sendTexts
        };
        this.handleChange = this.handleChange.bind(this);
        this.UserAction = this.UserAction.bind(this);
    }

    // Form value update function
    handleChange(evt) {
        this.setState({ [evt.target.name]: evt.target.value });
    }

    // Update values on submit function
    UserAction(evt) {
        evt.preventDefault();

        var i;
        var titles = []
        var icons = []
        var texts = []
        for (i = 0; i < sendTitles.length; i++) {
            titles[i] = sendTitles[i]['title'];
        }

        for (i = 0; i < sendTexts.length; i++) {
            texts[i] = sendTexts[i]['text'];
        }

        for (i = 0; i < sendIcons.length; i++) {
            icons[i] = sendIcons[i]['icon'];
        }

        let data = JSON.stringify({
            title: titles,
            pos: this.state.pos,
            colour: this.state.colour,
            text: texts,
            icon: icons
        })

        axios({
            method: 'PUT',
            mode: 'same-origin',
            url: 'http://localhost:8000/header/new/1/',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': csrftoken,
            },
            data: data,
        }).then(response => {
            console.log(response.data)
        }).catch(err => {
            console.log(err)
        })
    }

    render() {
        return (
            <Container>
                <h1>Dynamic Header</h1>
                <div className="form">
                    <Title />
                    <Icons />
                    <Text />

                    <TextField
                        name="colour"
                        label="Colour"
                        variant="filled"
                        value={this.state.colour}
                        onChange={this.handleChange}
                    />

                    <TextField
                        name="pos"
                        label="Menu direction"
                        variant="filled"
                        value={this.state.pos}
                        onChange={this.handleChange}
                    />
                    <Button
                        variant="contained"
                        color="primary"
                        type="submit"
                        onClick={this.UserAction}
                    >Send</Button>
                </div>
            </Container>

        );
    }
}