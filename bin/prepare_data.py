#!/usr/bin/env python
"""
Create the CSV files needed for the tables of the database.
"""
import os

import pandas as pd


def prepare_data(path_in):
    """Wrangle and prepare data for creating tables for database."""
    T_surface = 20
    cols_to_drop = [
        'uuid', 'name', 'site_name', 'other_location_name', 'api', 'shape',
        'precision_log_source_id'
    ]

    df = (
        pd.read_csv(path_in, dtype={'state_id': 'Int32', 'county_id': 'Int32'})
        .assign(gradient=lambda df: (df['bht'] - T_surface) / df['depth'])
        .dropna(subset=['bht', 'thermal_conductivity'], axis=0)
        .drop_duplicates(subset=['id'])
        .set_index('id')
        .drop(cols_to_drop, axis=1)
    )

    df_county, df_state, df_wells = normalize_data_frame(df)

    return df_county, df_state, df_wells


def normalize_data_frame(df):
    """Normalize the data frame by splitting the data across 3 tables."""
    def _normalize(df, columns, col_index):
        return (
            df[columns]
            .drop_duplicates()
            .dropna()
            .set_index(col_index)
        )

    df_county = _normalize(df, ['county_id', 'county'], 'county_id')
    df_state = _normalize(df, ['state_id', 'state_code', 'state'], 'state_id')
    df_wells = df.drop(['county', 'state', 'state_code'], axis=1)

    return df_county, df_state, df_wells


def main(path_in):
    dfs = prepare_data(path_in)
    filenames = ('counties.csv', 'states.csv', 'wells.csv')

    for df, filename in zip(dfs, filenames):
        df.to_csv(os.path.join('data', filename))


if __name__ == '__main__':
    import sys

    main(sys.argv[1])
